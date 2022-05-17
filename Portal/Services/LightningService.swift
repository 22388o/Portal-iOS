//
//  LightningService.swift
//  Portal
//
//  Created by farid on 5/16/22.
//  Copyright © 2022 Tides Network. All rights reserved.
//

import Foundation
import Combine
import BitcoinCore

class LightningService: ILightningService {
    var dataService: ILightningDataService
    var manager: ILightningChannelManager
    
    var blockChainDataSynced = CurrentValueSubject<Bool, Never>(false)
    
    private var bitcoinAdapter: BitcoinAdapter
    private var subscriptions = Set<AnyCancellable>()
    
    init(mnemonic: Data, adapter: BitcoinAdapter, dataService: ILightningDataService) {
        self.bitcoinAdapter = adapter
        self.dataService = dataService
        
        guard let bestBlock = adapter.lastBlockInfo else {
            fatalError("not synced with network")
        }
        
        print("Best block: \(bestBlock)")
        
        manager = LightningChannelManager(bestBlock: bestBlock, mnemonic: mnemonic)
                        
        bitcoinAdapter.transactionRecords
            .sink { [weak self] txs in
                guard let self = self else { return }
                
                for tx in txs {
                    print("=================================")
                    print("BTC transaction")
                    print("id: \(tx.transactionHash)")
                    print("amount: \(tx.amount)")
                    print("fee: \(tx.fee ?? 0)")
                    print("confirmations: \(tx.confirmations(lastBlockHeight: self.bitcoinAdapter.lastBlockInfo?.height))")
                    print("=================================")
                }
            }
            .store(in: &subscriptions)
        
        bitcoinAdapter.balanceStateUpdated
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                guard let self = self else { return }

                let state = self.bitcoinAdapter.balanceState
                if case let .syncing(currentProgress, _) = state {
                    print("Syncing... \(currentProgress)%")
                    
                    if self.blockChainDataSynced.value != false {
                        self.blockChainDataSynced.send(false)
                    }
                }
                if case .synced  = state {
                    Task {
                        do {
                            try await self.syncBlockchainData()
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
            .store(in: &subscriptions)
        
        bitcoinAdapter.lastBlockUpdated
            .buffer(size: .max, prefetch: .byRequest, whenFull: .dropOldest)
            .flatMap(maxPublishers: .max(1)) {
                Just($0).delay(for: .seconds(2), scheduler: DispatchQueue.global(qos: .background))
            }
            .sink { [weak self] newBlock in
                guard let self = self else { return }
                guard self.blockChainDataSynced.value else { return }
                
                Task {
                    do {
                        try await self.connect(block: newBlock)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            .store(in: &subscriptions)
        
        for node in dataService.nodes {
            for channel in node.channels {
                if channel.state != .closed && !node.connected {
                    connect(node: node)
                }
            }
        }
    }
    
    func connect(node: LightningNode) {
        node.connected = manager.peerNetworkHandler.connect(address: node.host, port: node.port, theirNodeId: node.nodeId)
        print("Node: \(node.alias) is \(node.connected ? "connected": "disconnected")")
    }
    
    func disconnect(node: LightningNode) {
        guard node.connected else { return }
        manager.constructor.peerManager.disconnect_by_node_id(node_id: node.nodeId, no_connection_possible: false)
        node.connected = false
        print("Node: \(node.alias) is \(node.connected ? "connected": "disconnected")")
    }
    
    func openChannelWith(node: LightningNode, sat: Int) {
        guard node.connected else {
            print("Cannot open a channel with \(node.alias): ISN'T CONNECTED")
            return
        }
        
        let userChannelId = UInt64.random(in: 10...1000)
        let config = UserConfig()
        
        let channelOpenResult = manager.constructor.channelManager.create_channel(
            their_network_key: node.nodeId,
            channel_value_satoshis: UInt64(sat),
            push_msat: 2000000,
            user_channel_id: userChannelId,
            override_config: config
        )
                
        if channelOpenResult.isOk() {
            print("Channel is open. Waiting funding tx")
            let channel = LightningChannel(id: Int16(userChannelId), satValue: Int64(sat), state: .waitingFunds, nodeAlias: node.alias)
            node.channels.append(channel)
            dataService.update(node: node)
        } else if let errorDetails = channelOpenResult.getError(){
            print("Channel open failed")
            
            if let error = errorDetails.getValueAsAPIMisuseError() {
                print("Misuse: \(error.getErr())")
            } else if let error = errorDetails.getValueAsRouteError() {
                print("Route: \(error.getErr())")
            } else if let error = errorDetails.getValueAsChannelUnavailable() {
                print("Channel Unavailable: \(error.getErr())")
            } else if let error = errorDetails.getValueAsFeeRateTooHigh() {
                print("fee rate: \(error.getErr())")
            } else if let error = errorDetails.getValueAsIncompatibleShutdownScript() {
                print("incompatible shutdown script: \(error.getScript())")
            }
        }
    }
    
    func createInvoice(amount: String, memo: String) -> String? {
        if let decimalAmount = Decimal(string: amount) {
            let satoshiAmount = bitcoinAdapter.convertToSatoshi(value: decimalAmount)
            let amount = Option_u64Z(value: UInt64(satoshiAmount))
            let descr = memo
            
            let result = Bindings.swift_create_invoice_from_channelmanager(channelmanager: manager.constructor.channelManager, keys_manager: manager.keysManager.as_KeysInterface(), network: LDKCurrency_BitcoinTestnet, amt_msat: amount, description: descr)

            if result.isOk(), let invoice = result.getValue() {
                let payment = LightningPayment(
                    id: UUID().uuidString,
                    satAmount: Int64(satoshiAmount),
                    date: Date(),
                    memo: memo,
                    state: .requested
                )
                
                dataService.save(payment: payment)

                return invoice.to_str()
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
}

extension LightningService {
    enum FetchingDataError: Error {
        case invalidURL
        case badHTTPResponseStatus
        case badHTTPResponseType
        case dataTransformation
        case missingBinary
    }
    //TODO: - move api calls to network layer
    private func getBlockBinary(hash: String) async throws -> Data {
        let urlString = "https://blockstream.info/testnet/api/block/\(hash)/raw"
        guard let url = URL(string: urlString) else {
            throw FetchingDataError.invalidURL
        }
        let request = URLRequest(url: url)
        let (blockData, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw FetchingDataError.badHTTPResponseStatus
        }
        guard let mime = httpResponse.mimeType, mime == "application/octet-stream" else {
            throw FetchingDataError.badHTTPResponseType
        }
        
        return blockData
    }
    
    private func connect(block: BlockInfo) async throws {
        let bestBlockHeight = manager.constructor.channelManager.current_best_block().height()
        
        guard block.height == bestBlockHeight + 1 else { return }
        
        let rawBlockData = try await getBlockBinary(hash: block.headerHash)
        
        let blockBinary = rawBlockData.bytes
        let blockHeight = UInt32(block.height)

        let channelManagerListener = manager.constructor.channelManager.as_Listen()
        channelManagerListener.block_connected(block: blockBinary, height: blockHeight)

        let chainMonitorListener = manager.chainMonitor.as_Listen()
        chainMonitorListener.block_connected(block: blockBinary, height: blockHeight)
                
        print("Block connected: \(block)")
    }
    
    private func syncBlockchainData() async throws {
        let bestBlockHeight = manager.constructor.channelManager.current_best_block().height()
        let newBlocks = bitcoinAdapter.blocks(from: Int(bestBlockHeight)).dropFirst()
                
        let channelManagerListener = manager.constructor.channelManager.as_Listen()
        let chainMonitorListener = manager.chainMonitor.as_Listen()
        
        for block in newBlocks {
            let blockBinary = try await getBlockBinary(hash: block.headerHash.reversedHex)
            let blockBytes = blockBinary.bytes
            let blockHeight = UInt32(block.height)
            channelManagerListener.block_connected(block: blockBytes, height: blockHeight)
            chainMonitorListener.block_connected(block: blockBytes, height: blockHeight)
        }
        
        manager.constructor.chain_sync_completed(persister: manager.channelManagerPersister, scorer: nil)
        blockChainDataSynced.send(true)
        
        print("Blockchain data synced. Balance: \(bitcoinAdapter.balance)")
    }
}
