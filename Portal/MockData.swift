//
//  MockData.swift
//  Portal
//
//  Created by Farid on 06.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import Foundation
import SwiftUI

struct BTC: WalletItemViewModel {
    var name  = "Bitcoin"
    var symbol = "BTC"
    var amount = "2.332502"
    var totalValue = "18353.23"
    var price = "$9125"
    var change = "+0.25%"
    var color = UIColor.green
}

struct BCH: WalletItemViewModel {
    var name  = "Bitcoin Cash"
    var symbol = "BCH"
    var amount = "10.2502"
    var totalValue = "3220.23"
    var price = "$322.23"
    var change = "+2.15%"
    var color = UIColor.gray
}

struct ETH: WalletItemViewModel {
    var name  = "Ethereum"
    var symbol = "ETH"
    var amount = "20.332502"
    var totalValue = "4353.23"
    var price = "$215"
    var change = "+6.25%"
    var color = UIColor.blue
}

struct LPT: WalletItemViewModel {
    var name  = "Livepeer Token"
    var symbol = "LPT"
    var amount = "2.13"
    var totalValue = "3.16"
    var price = "$215"
    var change = "+0.02%"
    var color = UIColor.yellow
}

struct CoinMock: WalletItemViewModel {}

let WalletMock: [WalletItemViewModel] = [BTC(), BCH(), ETH(), LPT(), CoinMock()]

enum Currency: Int {
    case usd
    case btc
    case eth
    
    func stringValue() -> String {
        switch self {
        case .usd: return "USD"
        case .btc: return "BTC"
        case .eth: return "ETH"
        }
    }
}
