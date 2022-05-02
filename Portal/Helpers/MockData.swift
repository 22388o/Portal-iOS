//
//  MockData.swift
//  Portal
//
//  Created by Farid on 06.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import Foundation
import SwiftUI

let btcMockAddress = "1HqwV7F9hpUpJXubLFomcrNMUqPLzeTVNd"

let USD = FiatCurrency(code: "USD", name: "American Dollar")

final class MockCoinKit: ICoinKit {
    var balance: Double {
        Double.random(in: 0.285..<2.567).rounded(toPlaces: 4)
    }
    func send(amount: Double) {
        print("Send coins...")
    }
}

class WalletMock: IWallet {
    var walletID: UUID = UUID()
    
    var assets = [IAsset]()
    
    init() {
        let btc = Coin.bitcoin()
        let eth = Coin.ethereum()
        
        self.assets = [
            Asset(coin: btc),
            Asset(coin: eth)
        ]
    }
    
    func setup() {}
}

//let CoinsMock: [Asset] = [BTC(), BCH(), ETH(), XLM(), XTZ()]
