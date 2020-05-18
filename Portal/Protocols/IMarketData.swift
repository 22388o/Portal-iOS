//
//  IMarketData.swift
//  Portal
//
//  Created by Farid on 14.04.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import Foundation

protocol IMarketData {
    func marketData(for coin: String) -> CoinMarketData
    func rate(for currency: FiatCurrency) -> Double
    func pause()
    func resume()
}

extension IMarketData {
    var assetSymbols: [String] {
        ["BTC", "BCH", "ETH"]
    }
}
