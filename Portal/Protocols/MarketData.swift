//
//  MarketData.swift
//  Portal
//
//  Created by Farid on 14.04.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import Foundation

protocol MarketData {
    func marketData(for coin: String) -> CoinMarketData
    func rate(for currency: FiatCurrency) -> Double
}

extension MarketData {
    var assetSymbols: [String] {
        ["BTC", "BCH", "ETH"]
    }
}
