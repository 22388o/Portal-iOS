//
//  LightningChannelManager.swift
//  Portal
//
//  Created by farid on 5/16/22.
//  Copyright © 2022 Tides Network. All rights reserved.
//

import Foundation

class LightningChannelManager: ILightningChannelManager {
    var constructor: ChannelManagerConstructor
    var chainMonitor: ChainMonitor
    var peerNetworkHandler: TCPPeerHandler
    var keysManager: KeysManager
    var channelManagerPersister: ExtendedChannelManagerPersister
    
    init(lastKnownBlock: LastBlockInfo, mnemonic: Data) {
        let userConfig = UserConfig()
        let network = LDKNetwork_Testnet
        
        let filter = TestFilter()
        let filterOption = Option_FilterZ(value: filter)
        let feeEstimator = TestFeeEstimator()
        let persister = TestPersister()
        let broadcaster = RegtestBroadcasterInterface()
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
        
        //TODO: - db models needed
        let defaults = UserDefaults.standard
        
        if let channelManagerData = defaults.data(forKey: "manager")?.bytes,
            let networkGraphSerialized = defaults.data(forKey: "netGraph")?.bytes {
            // restoring node

            do {
                constructor = try ChannelManagerConstructor(
                    channel_manager_serialized: channelManagerData,
                    channel_monitors_serialized: [],
                    keys_interface: keysManager.as_KeysInterface(),
                    fee_estimator: feeEstimator,
                    chain_monitor: chainMonitor,
                    filter: filter,
                    net_graph_serialized: networkGraphSerialized,
                    tx_broadcaster: broadcaster,
                    logger: logger
                )
            } catch {
                fatalError("\(error.localizedDescription)")
            }

        } else {
            //start new node
        
            let reversedLastBlockHash = lastKnownBlock.headerHash.reversed
            let chainTipHash = Block.hexStringToBytes(hexString: reversedLastBlockHash)!
            let chainTipHeight = UInt32(lastKnownBlock.height)
            
            //test net genesis block hash
            let reversedGenesisBlockHash = "000000000933ea01ad0ee984209779baaec3ced90fa3f408719526f8d77f4943".reversed
            let genesis_hash = Block.hexStringToBytes(hexString: reversedGenesisBlockHash)!
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
        print("Best block height: \(bestBlockHeight), hash: \(Block.bytesToHexString(bytes: bestBlockHash))")
        
        channelManagerPersister = RegtestChannelManagerPersister(channelManager: constructor.channelManager)
        peerNetworkHandler = TCPPeerHandler(peerManager: constructor.peerManager)
    }
}
