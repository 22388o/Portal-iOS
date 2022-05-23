//
//  LightningChannelManager.swift
//  Portal
//
//  Created by farid on 5/16/22.
//  Copyright © 2022 Tides Network. All rights reserved.
//

import Foundation
import BitcoinCore

class LightningChannelManager: ILightningChannelManager {
    private var constructor: ChannelManagerConstructor
    
    var channelManager: ChannelManager {
        constructor.channelManager
    }
    
    var payer: InvoicePayer? {
        constructor.payer
    }
    
    var peerManager: PeerManager {
        constructor.peerManager
    }
    
    var chainMonitor: ChainMonitor
    var peerNetworkHandler: TCPPeerHandler
    var keysManager: KeysManager
    var channelManagerPersister: ExtendedChannelManagerPersister
    var dataService: ILightningDataService
    
    init(bestBlock: BlockInfo, mnemonic: Data, dataService: ILightningDataService) {
        self.dataService = dataService
        
        let userConfig = UserConfig()
        let network = LDKNetwork_Testnet
        
        let filter = TestFilter()
        let filterOption = Option_FilterZ(value: filter)
        let feeEstimator = FeesEstimator()
        let persister = ChannelPersister(dataService: dataService)
        let broadcaster = TestNetBroadcasterInterface()
        let logger = TestLogger()
    
        let seed = mnemonic.bytes
        let timestamp_seconds = UInt64(Date().timeIntervalSince1970)
        let timestamp_nanos = UInt32(truncating: NSNumber(value: timestamp_seconds * 1000 * 1000))
        
        keysManager = KeysManager(seed: seed, starting_time_secs: timestamp_seconds, starting_time_nanos: timestamp_nanos)
        
        chainMonitor = ChainMonitor(
            chain_source: filterOption.dangle(),
            broadcaster: broadcaster,
            logger: logger,
            feeest: feeEstimator,
            persister: persister
        )
        
        if let channelManagerSerialized = dataService.channelManagerData?.bytes {

            let networkGraphSerizlized = dataService.networkGraph?.bytes ?? []
            let channelMonitorsSeriaziled = dataService.channelMonitors?.map{ $0.bytes } ?? []

            do {
                constructor = try ChannelManagerConstructor(
                    channel_manager_serialized: channelManagerSerialized,
                    channel_monitors_serialized: channelMonitorsSeriaziled,
                    keys_interface: keysManager.as_KeysInterface(),
                    fee_estimator: feeEstimator,
                    chain_monitor: chainMonitor,
                    filter: filter,
                    net_graph_serialized: networkGraphSerizlized,
                    tx_broadcaster: broadcaster,
                    logger: logger
                )
            } catch {
                fatalError("\(error)")
            }

        } else {
            //start new node
        
            let reversedLastBlockHash = bestBlock.headerHash.reversed
            let chainTipHash = LDKBlock.hexStringToBytes(hexString: reversedLastBlockHash)!
            let chainTipHeight = UInt32(bestBlock.height)
            
            //test net genesis block hash
            let reversedGenesisBlockHash = "000000000933ea01ad0ee984209779baaec3ced90fa3f408719526f8d77f4943".reversed
            let genesis_hash = LDKBlock.hexStringToBytes(hexString: reversedGenesisBlockHash)!
            let networkGraph = NetworkGraph(genesis_hash: genesis_hash)
            
            constructor = ChannelManagerConstructor(
                network: network,
                config: userConfig,
                current_blockchain_tip_hash: chainTipHash,
                current_blockchain_tip_height: chainTipHeight,
                keys_interface: keysManager.as_KeysInterface(),
                fee_estimator: feeEstimator,
                chain_monitor: chainMonitor,
                net_graph: networkGraph,
                tx_broadcaster: broadcaster,
                logger: logger
            )
        }
        
        let bestBlockHeight = constructor.channelManager.current_best_block().height()
        let bestBlockHash = constructor.channelManager.current_best_block().block_hash()
        print("Best block height: \(bestBlockHeight), hash: \(LDKBlock.bytesToHexString(bytes: bestBlockHash))")
        
        channelManagerPersister = ChannelManagerPersister(channelManager: constructor.channelManager, dataService: dataService)
        peerNetworkHandler = TCPPeerHandler(peerManager: constructor.peerManager)
    }
    
    func chainSyncCompleted() {
        let scorer = MultiThreadedLockableScore(score: Scorer().as_Score())
        constructor.chain_sync_completed(persister: channelManagerPersister, scorer: scorer)
    }
}

