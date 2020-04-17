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

struct BTC: WalletItemViewModel {
    var name  = "Bitcoin"
    var symbol = "BTC"
    var amount = "2.332502"
    var totalValue = "18353.23"
    var price = "$9125"
    var change = "+0.25%"
    var color = UIColor.green
    var icon = UIImage(imageLiteralResourceName: "iconBtc")
}

struct BCH: WalletItemViewModel {
    var name  = "Bitcoin Cash"
    var symbol = "BCH"
    var amount = "10.2502"
    var totalValue = "3220.23"
    var price = "$322.23"
    var change = "+2.15%"
    var color = UIColor.gray
    var icon = UIImage(imageLiteralResourceName: "iconBch")
}

struct ETH: WalletItemViewModel {
    var name  = "Ethereum"
    var symbol = "ETH"
    var amount = "20.332502"
    var totalValue = "4353.23"
    var price = "$215"
    var change = "+6.25%"
    var color = UIColor.blue
    var icon = UIImage(imageLiteralResourceName: "iconEth")
}

struct XLM: WalletItemViewModel {
    var name  = "Stellar Lumens"
    var symbol = "XLM"
    var amount = "200.13"
    var totalValue = "0.04"
    var price = "$8"
    var change = "+0.02%"
    var color = UIColor.red
    var icon = UIImage(imageLiteralResourceName: "iconXlm")
}

struct XTZ: WalletItemViewModel {
    var name  = "Tezos"
    var symbol = "XTZ"
    var amount = "1.42"
    var totalValue = "30.16"
    var price = "$32.15"
    var change = "+0.02%"
    var color = UIColor.lightGray
    var icon = UIImage(imageLiteralResourceName: "iconXtz")
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

struct CoinMock: WalletItemViewModel {
    var icon = UIImage(imageLiteralResourceName: "iconBtc")
}

let WalletMock: [WalletItemViewModel] = [BTC(), BCH(), ETH(), XLM(), XTZ()]
