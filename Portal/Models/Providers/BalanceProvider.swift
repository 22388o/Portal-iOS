//
//  BalanceProvider.swift
//  Portal
//
//  Created by Farid on 19.05.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import Foundation

final class BalanceProvider: IBalanceProvider {
    let coin: Coin
    let coinKit: ICoinKit
    
    init(coin: Coin, kit: ICoinKit) {
        self.coin = coin
        self.coinKit = kit
    }
    
    var balanceString: String {
       "\(coinKit.balance)"
    }
    
    var totalValueString: String {
        "\(Double.random(in: 255..<5955).rounded(toPlaces: 2))"
    }
    
    func balance(currency: UserCurrency) -> Double {
        Double.random(in: 0.0125 ..< 2.795).rounded(toPlaces: 1)
        //balance * marketData.price(currency: currency)
    }
}
