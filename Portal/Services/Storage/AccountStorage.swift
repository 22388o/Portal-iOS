//
//  AccountStorage.swift
//  Portal
//
//  Created by Farid on 22.07.2021.
//

import Foundation

class AccountStorage {
    private let localStorage: ILocalStorage
    private let secureStorage: IKeychainStorage
    private let accountStorage: IAccountStorage

    init(localStorage: ILocalStorage, secureStorage: IKeychainStorage, accountStorage: IAccountStorage) {
        self.localStorage = localStorage
        self.secureStorage = secureStorage
        self.accountStorage = accountStorage
    }

    private func createAccount(record: AccountRecord) -> Account? {
        let id = record.id
        let type: AccountType

        guard let words = recoverStringArray(id: id, typeName: .mnemonic, keyName: .words) else {
            return nil
        }
        guard let salt: String = recover(id: id, typeName: .mnemonic, keyName: .salt) else {
            return nil
        }

        type = .mnemonic(words: words, salt: salt)
        
        return Account(record: record, type: type)
    }

    private func createRecord(account: Account) throws -> AccountRecord {
        let id = account.id

        let typeName: TypeName

        switch account.type {
        case .mnemonic(let words, let salt):
            typeName = .mnemonic
            _ = try store(stringArray: words, id: id, typeName: typeName, keyName: .words)
            _ = try store(salt, id: id, typeName: typeName, keyName: .salt)
        }
        
        return AccountRecord(id: id, name: account.name, bip: account.mnemonicDereviation, context: accountStorage.context)
    }

    private func clearSecureStorage(account: Account) throws {
        let id = account.id

        switch account.type {
        case .mnemonic:
            try secureStorage.removeValue(for: secureKey(id: id, typeName: .mnemonic, keyName: .words))
            try secureStorage.removeValue(for: secureKey(id: id, typeName: .mnemonic, keyName: .salt))
        }
    }

    private func secureKey(id: String, typeName: TypeName, keyName: KeyName) -> String {
        "\(keyName.rawValue)_\(id)_\(typeName.rawValue)"
    }

    private func store(stringArray: [String], id: String, typeName: TypeName, keyName: KeyName) throws -> String {
        try store(stringArray.joined(separator: ","), id: id, typeName: typeName, keyName: keyName)
    }

    private func store<T: LosslessStringConvertible>(_ value: T, id: String, typeName: TypeName, keyName: KeyName) throws -> String {
        let key = secureKey(id: id, typeName: typeName, keyName: keyName)
        try secureStorage.set(value: value, for: key)
        return key
    }

    private func store(data: Data, id: String, typeName: TypeName, keyName: KeyName) throws -> String {
        let key = secureKey(id: id, typeName: typeName, keyName: keyName)
        try secureStorage.set(value: data, for: key)
        return key
    }

    private func recoverStringArray(id: String, typeName: TypeName, keyName: KeyName) -> [String]? {
        let string: String? = recover(id: id, typeName: typeName, keyName: keyName)
        return string?.split(separator: ",").map { String($0) }
    }

    private func recover<T: LosslessStringConvertible>(id: String, typeName: TypeName, keyName: KeyName) -> T? {
        let key = secureKey(id: id, typeName: typeName, keyName: keyName)
        return secureStorage.value(for: key)
    }

    private func recoverData(id: String, typeName: TypeName, keyName: KeyName) -> Data? {
        let key = secureKey(id: id, typeName: typeName, keyName: keyName)
        return secureStorage.value(for: key)
    }
}

extension AccountStorage {
    var activeAccount: Account? {
        guard
            let currentAccountID = localStorage.getCurrentAccountID(),
            let record = accountStorage.allAccountRecords.first(where: { $0.id == currentAccountID })
        else { return nil }
        
        return createAccount(record: record)
    }

    var allAccounts: [Account] {
        accountStorage.allAccountRecords.compactMap { createAccount(record: $0) }
    }

    func save(account: Account) {
        if let record = try? createRecord(account: account) {
            accountStorage.save(accountRecord: record)
            localStorage.setCurrentAccountID(record.id)
        }
    }

    func delete(account: Account) {
        try? accountStorage.deleteAccount(account)
        try? clearSecureStorage(account: account)
    }

    func clear() {
        accountStorage.deleteAllAccountRecords()
    }
    
    func setCurrentAccount(id: String) {
        localStorage.setCurrentAccountID(id)
    }

    func update(account: Account) {
        accountStorage.update(account: account)
    }
}

extension AccountStorage {

    private enum TypeName: String {
        case mnemonic
        case privateKey
    }

    private enum KeyName: String {
        case words
        case salt
        case data
        case privateKey
    }

}