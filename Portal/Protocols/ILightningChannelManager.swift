//
//  ILightningChannelManager.swift
//  Portal
//
//  Created by farid on 5/16/22.
//  Copyright © 2022 Tides Network. All rights reserved.
//

import Foundation

protocol ILightningChannelManager {
    var constructor: ChannelManagerConstructor { get }
    var chainMonitor: ChainMonitor { get }
    var channelManagerPersister: ExtendedChannelManagerPersister { get }
    var keysManager: KeysManager { get }
    var peerNetworkHandler: TCPPeerHandler { get }
}
