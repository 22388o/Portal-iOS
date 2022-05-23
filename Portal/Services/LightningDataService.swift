//
//  LightningDataService.swift
//  Portal
//
//  Created by farid on 5/20/22.
//  Copyright © 2022 Tides Network. All rights reserved.
//

import Foundation

class LightningDataService: ILightningDataService {
    
    private let storage: ILightningDataStorage
    
    init(storage: ILightningDataStorage) {
        self.storage = storage
        
        if nodes.isEmpty {
            try? storage.save(nodes: LightningNode.sampleNodes)
        }
    }
    
    var channelManagerData: Data? {
        do {
            return try storage.fetchChannelManager()
        } catch {
            print(error)
            return nil
        }
    }
    
    var networkGraph: Data? {
        do {
            return try storage.fetchNetGraph()
        } catch {
            print(error)
            return nil
        }
    }
    
    var channelMonitors: [Data]? {
        do {
            return try storage.fetchChannelMonitors()
        } catch {
            print(error)
            return nil
        }
    }
        
    var nodes: [LightningNode] {
        do {
            return try storage.fetchNodes()
        } catch {
            print(error)
            return []
        }
    }
    
    var channels: [LightningChannel] {
        do {
            return try storage.fetchChannels()
        } catch {
            print(error)
            return []
        }
    }
    
    var payments: [LightningPayment] {
        do {
            return try storage.fetchPayments()
        } catch {
            print(error)
            return []
        }
    }
    
    func update(node: LightningNode) {
        do {
            try storage.update(node: node)
        } catch {
            print(error)
        }
    }
    
    func update(channel: LightningChannel) {
        do {
            try storage.update(channel: channel)
        } catch {
            print(error)
        }
    }
    
    func update(payment: LightningPayment) {
        do {
            try storage.update(payment: payment)
        } catch {
            print(error)
        }
    }
    
    func save(channel: LightningChannel) {
        do {
            try storage.save(channel: channel)
        } catch {
            print(error)
        }
    }
    
    func save(payment: LightningPayment) {
        do {
            try storage.save(payment: payment)
        } catch {
            print(error)
        }
    }
    
    func save(channelManager: Data) {
        do {
            try storage.save(channelManager: channelManager)
        } catch {
            print(error)
        }
    }
    
    func save(networkGraph: Data) {
        do {
            try storage.save(networkGraph: networkGraph)
        } catch {
            print(error)
        }
    }
    
    func update(channelMonitor: Data, id: String) {
        do {
            try storage.update(channelMonitor: channelMonitor, id: id)
        } catch {
            print(error)
        }
    }
    
    func channelWith(id: UInt64) -> LightningChannel? {
        var channel: LightningChannel?
        do {
            channel = try storage.channelWith(id: id)
        } catch {
            print(error)
        }
        return channel
    }
    
    func removeChannelWith(id: UInt64) {
        do {
            try storage.removeChannelWith(id: id)
        } catch {
            print(error)
        }
    }
}