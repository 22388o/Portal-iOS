//
//  MockData.swift
//  Portal
//
//  Created by Farid on 06.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import Foundation

struct BTC: WalletItemViewModel {
    var name  = "Bitcoin"
    var symbol = "BTC"
    var amount = "2.332502"
    var totalValue = "18353.23"
    var price = "$9125"
    var change = "+0.25%"
}

struct ETH: WalletItemViewModel {
    var name  = "Ethereum"
    var symbol = "ETH"
    var amount = "20.332502"
    var totalValue = "4353.23"
    var price = "$215"
    var change = "+6.25%"
}

struct CoinMock: WalletItemViewModel {}
