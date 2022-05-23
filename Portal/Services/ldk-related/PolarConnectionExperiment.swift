//
//  PolarConnectionExperiment.swift
//  DirectBindingsApp
//
//  Created by Arik Sosman on 8/27/21.
//

import Foundation
import Combine
import HdWalletKit
import BitcoinCore

class PolarConnectionExperiment: ObservableObject {
    static let shared = PolarConnectionExperiment()
    var bitcoinAdapter: BitcoinAdapter
    var service: ILightningService
    @Published var errorMessage: String?
    
    init() {
        let btcCoin = Coin.bitcoin()
        
        let words = ["small", "bright", "pride", "civil", "below", "elbow", "mutual", "again", "short", "join", "glove", "library", "produce", "unusual", "local", "denial", "hope", "bright", "grape", "vibrant", "range", "repeat", "flip", "toe"]
        
        let salt = "salty_password"
        
        let btcAccount = Account(
            id: "BitcoinAdapterIDString.portal",
            name: "BitcoinAccount",
            bip: .bip84,
            type: .mnemonic(words: words, salt: salt)
        )
        
        let btcWallet = Wallet(coin: btcCoin, account: btcAccount)
        
        bitcoinAdapter = try! BitcoinAdapter(wallet: btcWallet, syncMode: .fast)
        bitcoinAdapter.start()
                
        guard let mnemonicSeed = btcWallet.account.type.mnemonicSeed else {
            fatalError("cant get seed")
        }
            
        let lightningDataService = LightningDataService(storage: WalletCoordinator.shared)
        service = LightningService(mnemonic: mnemonicSeed, adapter: bitcoinAdapter, dataService: lightningDataService)
    }
    
    func createRawTransaction(outputScript: [UInt8], amount: UInt64) throws -> Data? {
        let scriptConverter = ScriptConverter()
        let addressConverter = SegWitBech32AddressConverter(prefix: "tb", scriptConverter: scriptConverter)
        
        let receiverAddress = try addressConverter.convert(keyHash: Data(outputScript), type: .p2wsh)
        let address = receiverAddress.stringValue
        
        let txData = try bitcoinAdapter.createRawTransaction(amountSat: amount, address: address, feeRate: 80, sortMode: .shuffle)
        
        print("TX DATA: \(txData.hex)")
        
        return txData
    }
}
