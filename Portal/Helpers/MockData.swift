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

class BTCViewModel: CoinViewModel {
    var name  = "Bitcoin"
    var symbol = "BTC"
    var amount = "2.332502"
    var totalValue = "18353.23"
    var price = "$9125"
    var change = "+0.25%"
    var color = UIColor.green
    var icon = UIImage(imageLiteralResourceName: "iconBtc")
    
    @Published var marketData: CoinMarketData
    
    init(marketData: CoinMarketData) {
        self.marketData = marketData
    }
}

final class BTC: Asset {
    var viewModel: CoinViewModel
    
    init(marketData: CoinMarketData = CoinMarketData()) {
        viewModel = BTCViewModel(marketData: marketData)
    }
}

class BCHViewModel: CoinViewModel {
    var name  = "Bitcoin Cash"
    var symbol = "BCH"
    var amount = "10.2502"
    var totalValue = "3220.23"
    var price = "$322.23"
    var change = "+2.15%"
    var color = UIColor.gray
    var icon = UIImage(imageLiteralResourceName: "iconBch")
    
    @Published var marketData: CoinMarketData
    
    init(marketData: CoinMarketData) {
        self.marketData = marketData
    }
}

final class BCH: Asset {
    var viewModel: CoinViewModel
    
    init(marketData: CoinMarketData = CoinMarketData()) {
        viewModel = BCHViewModel(marketData: marketData)
    }
}

class ETHViewModel: CoinViewModel {
    var name  = "Ethereum"
    var symbol = "ETH"
    var amount = "20.332502"
    var totalValue = "4353.23"
    var price = "$215"
    var change = "+6.25%"
    var color = UIColor.blue
    var icon = UIImage(imageLiteralResourceName: "iconEth")
    
    @Published var marketData: CoinMarketData
    
    init(marketData: CoinMarketData) {
        self.marketData = marketData
    }
}

final class ETH: Asset {
    var viewModel: CoinViewModel
    
    init(marketData: CoinMarketData = CoinMarketData()) {
        viewModel = ETHViewModel(marketData: marketData)
    }
}

class XLMViewModel: CoinViewModel {
    var name  = "Stellar Lumens"
    var symbol = "XLM"
    var amount = "200.13"
    var totalValue = "0.04"
    var price = "$8"
    var change = "+0.02%"
    var color = UIColor.red
    var icon = UIImage(imageLiteralResourceName: "iconXlm")
    
    @Published var marketData: CoinMarketData
    
    init(marketData: CoinMarketData) {
        self.marketData = marketData
    }
}

final class XLM: Asset {
    var viewModel: CoinViewModel
    
    init(marketData: CoinMarketData = CoinMarketData()) {
        viewModel = XLMViewModel(marketData: marketData)
    }
}

class XTZViewModel: CoinViewModel {
    var name  = "Tezos"
    var symbol = "XTZ"
    var amount = "1.42"
    var totalValue = "30.16"
    var price = "$32.15"
    var change = "+0.02%"
    var color = UIColor.lightGray
    var icon = UIImage(imageLiteralResourceName: "iconXtz")
    
    @Published var marketData: CoinMarketData
    
    init(marketData: CoinMarketData) {
        self.marketData = marketData
    }
}

final class XTZ: Asset {
    var viewModel: CoinViewModel
    
    init(marketData: CoinMarketData = CoinMarketData()) {
        viewModel = XTZViewModel(marketData: marketData)
    }
}

class LPTViewModel: CoinViewModel {
    var name  = "Livepeer Token"
    var symbol = "LPT"
    var amount = "2.13"
    var totalValue = "3.16"
    var price = "$215"
    var change = "+0.02%"
    var color = UIColor.yellow
    
    @Published var marketData: CoinMarketData
    
    init(marketData: CoinMarketData) {
        self.marketData = marketData
    }
}

final class LPT: Asset {
    var viewModel: CoinViewModel
    
    init(marketData: CoinMarketData = CoinMarketData()) {
        viewModel = LPTViewModel(marketData: marketData)
    }
}

struct CoinMock: CoinViewModel {
    var marketData: CoinMarketData = CoinMarketData()
    
    var icon = UIImage(imageLiteralResourceName: "iconBtc")
}

class WalletMock: Wallet {
    
    var assets = [Asset]()
    
    init() {
        self.assets = [
            BTC(marketData: CoinMarketData()),
            BCH(marketData: CoinMarketData()),
            ETH(marketData: CoinMarketData()),
            XLM(marketData: CoinMarketData()),
            XTZ(marketData: CoinMarketData())
        ]
    }
}

//let CoinsMock: [Asset] = [BTC(), BCH(), ETH(), XLM(), XTZ()]
