//
//  PolarConnectionExperiment.swift
//  DirectBindingsApp
//
//  Created by Arik Sosman on 8/27/21.
//

import Foundation
import Combine
import HdWalletKit

class PolarConnectionExperiment: ObservableObject {
    static let shared = PolarConnectionExperiment()
    var bitcoinAdapter: BitcoinAdapter
    var service: ILightningService
    
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
}
