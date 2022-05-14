//
//  WalletCoordinator.swift
//  Portal
//
//  Created by Farid on 14.05.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import Foundation
import CoreData
import KeychainAccess

final class WalletCoordinator: ObservableObject {
    static let shared = WalletCoordinator()
    @Published var currentWallet: IWallet?
    var wallets: [IWallet]?
    
    private var keychainStorage: KeychainStorage
    var context: NSManagedObjectContext?

    static private let currentWalletIDKey = "CURRENT_WALLET_ID"
    
    private var currentWalletID: String? {
        get {
            return keychainStorage.string(for: WalletCoordinator.currentWalletIDKey)
        }
        set {
            guard let value = newValue else { return }
            self.keychainStorage.save(string: value, key: WalletCoordinator.currentWalletIDKey)
        }
    }
    
    convenience init(mockedWallet: IWallet) {
        self.init()
        currentWallet = mockedWallet
    }
    
    init(context: NSManagedObjectContext? = nil) {
        //context is optional for tests
        self.keychainStorage = KeychainStorage(keychain: Keychain(service: "com.portal.keychain.service"))
//
//        guard context != nil else { return }
//
//        self.context = context
//
//        fetchWallets()
//        setupCurrentWallet()
    }
    
    func load() {
        fetchWallets()
        setupCurrentWallet()
    }
    
    private func fetchWallets() {
        let request = DBWallet.fetchRequest() as NSFetchRequest<DBWallet>
                
        if let wallets = try? self.context?.fetch(request) {
//            clearWallets(wallets: wallets)
            self.wallets = wallets
        }
    }
    
    private func setupCurrentWallet() {
        if let fetchedCurrentWalletID = currentWalletID {
            setupWallet(id: fetchedCurrentWalletID)
        }
    }
    
    private func saveSeed(data: Data, key: String) {
        if Device.hasSecureEnclave {
            keychainStorage.save(data: data, key: key)
//            fatalError("Not implemented yet")
        } else {
            keychainStorage.save(data: data, key: key)
        }
    }
    
    private func clearWallets(wallets: [DBWallet]) {
        try? keychainStorage.clear()
        for wallet in wallets {
            context?.delete(wallet)
        }
        try? context?.save()
    }
}

extension WalletCoordinator: IWalletCoordinator {
    func setupWallet(id: String) {
        if let current = wallets?.first(where: { $0.walletID.uuidString == id }) {
            currentWallet = current
            
            guard
                let key = (currentWallet as? DBWallet)?.key,
                let data = keychainStorage.data(for: key) else { return }
            
            (currentWallet as? DBWallet)?.setup(data: data)
        } else {
            fatalError("Wallet with id \(id) isn't exist")
        }
    }
    
    func createWallet(model: NewWalletModel) {
        guard let context = self.context else {
            fatalError("Cannot get context to create wallet.")
        }
                    
        guard let data = model.seedData else {
            fatalError("Cannot get seed data")
        }
        
        let newWallet = DBWallet(model: model, context: context)
        newWallet.setup(data: data)
        saveSeed(data: data, key: newWallet.key)
        
        currentWalletID = newWallet.id.uuidString
        currentWallet = newWallet
    }
    
    func restoreWallet() {
        
    }
}

enum DBError: Error {
    case missingContext
    case fetchingError
    case storingError
}

class LightningDataService: ILightningDataService {
    
    private let storage: ILightningDataStorage
    
    init(storage: ILightningDataStorage) {
        self.storage = storage
        
        if nodes.isEmpty {
            try? storage.save(nodes: LightningNode.sampleNodes)
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
}

extension WalletCoordinator: ILightningDataStorage {

    func fetchNodes() throws -> [LightningNode] {
        guard let context = context else { throw DBError.missingContext }
        
        let request = DBLightningNode.fetchRequest() as NSFetchRequest<DBLightningNode>
        var nodes = [LightningNode]()
        
        try context.performAndWait {
            do {
                let records = try context.fetch(request)
                nodes = records.map { LightningNode(record: $0) }
            } catch {
                throw DBError.fetchingError
            }
        }
        
        return nodes
    }
    
    func fetchChannels() throws -> [LightningChannel] {
        guard let context = context else { throw DBError.missingContext }
        
        let request = DBLightningChannel.fetchRequest() as NSFetchRequest<DBLightningChannel>
        var channels = [LightningChannel]()
        
        try context.performAndWait {
            do {
                let records = try context.fetch(request)
                channels = records.map { LightningChannel(record: $0) }
            } catch {
                throw DBError.fetchingError
            }
        }
        
        return channels
    }
    
    func fetchPayments() throws -> [LightningPayment] {
        guard let context = context else { throw DBError.missingContext }
        
        let request = DBLightningPayment.fetchRequest() as NSFetchRequest<DBLightningPayment>
        var payments = [LightningPayment]()
        
        try context.performAndWait {
            do {
                let records = try context.fetch(request)
                payments = records.map { LightningPayment(record: $0) }
            } catch {
                throw DBError.fetchingError
            }
        }
        
        return payments
    }
    
    func save(nodes: [LightningNode]) throws {
        guard let context = context else { throw DBError.missingContext }
        
        try context.performAndWait {
            do {
                for node in nodes {
                    let dbNode = DBLightningNode(context: context)
                    dbNode.alias = node.alias
                    dbNode.publicKey = node.publicKey
                    dbNode.host = node.host
                    dbNode.port = Int16(node.port)
                }
                try context.save()
            } catch {
                throw DBError.storingError
            }
        }
    }
    
    func save(channel: LightningChannel) throws {
        guard let context = context else { throw DBError.missingContext }
        
        let newChannel = DBLightningChannel(context: context)
        newChannel.channelID = Int16(channel.id)
        newChannel.satValue = Int64(channel.satValue)
        newChannel.state = channel.state.rawValue
        
        try context.performAndWait {
            do {
                try context.save()
            } catch {
                throw DBError.fetchingError
            }
        }
    }
    
    func save(payment: LightningPayment) throws {
        guard let context = context else { throw DBError.missingContext }
        
        let record = DBLightningPayment(context: context)
        record.paymentID = payment.id
        record.satValue = Int64(payment.satAmount)
        record.memo = payment.memo
        record.date = payment.date
        
        try context.performAndWait {
            do {
                try context.save()
            } catch {
                throw DBError.storingError
            }
        }

    }
    
    func update(node: LightningNode) throws {
        guard let context = context else { throw DBError.missingContext }
        
        let request = DBLightningNode.fetchRequest() as NSFetchRequest<DBLightningNode>
        
        try context.performAndWait {
            do {
                let records = try context.fetch(request)
                
                if let record = records.first(where: { $0.id == node.id }) {
                    record.alias = node.alias
                    record.publicKey = node.publicKey
                    record.host = node.host
                    record.port = Int16(node.port)
                    
                    for channel in node.channels {
                        let channelRecord = DBLightningChannel(context: context)
                        channelRecord.satValue = Int64(channel.satValue)
                        channelRecord.channelID = Int16(channel.id)
                        channelRecord.state = channel.state.rawValue
                    }
                    
                    try context.save()
                } else {
                    throw DBError.storingError
                }
            } catch {
                throw DBError.fetchingError
            }
        }
    }
    
    func update(channel: LightningChannel) throws {
        guard let context = context else { throw DBError.missingContext }
        
        let request = DBLightningChannel.fetchRequest() as NSFetchRequest<DBLightningChannel>
        
        try context.performAndWait {
            do {
                let records = try context.fetch(request)
                
                if let record = records.first(where: { $0.id == channel.id }) {
                    record.state = channel.state.rawValue
                    try context.save()
                } else {
                    throw DBError.storingError
                }
            } catch {
                throw DBError.fetchingError
            }
        }
    }
    
    func update(payment: LightningPayment) throws {
        guard let context = context else { throw DBError.missingContext }
        
        let request = DBLightningPayment.fetchRequest() as NSFetchRequest<DBLightningPayment>
        
        try context.performAndWait {
            do {
                let records = try context.fetch(request)
                
                if let record = records.first(where: { $0.paymentID == payment.id }) {
                    record.state = payment.state.rawValue
                    record.satValue = Int64(payment.satAmount)
                    record.memo = payment.memo
                    record.date = payment.date
                    
                    try context.save()
                } else {
                    throw DBError.storingError
                }
            } catch {
                throw DBError.fetchingError
            }
        }
    }
    
    
}
