//
//  MarketDataRepository.swift
//  Portal
//
//  Created by Farid on 14.04.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class MarketDataRepository: MarketData  {
    @ObservedObject private var ratesUpdater = RatesDataUpdater()
    
    private var ratesCancellable: AnyCancellable?
    
    private var currencyRates = Synchronized([String: Double]())
    private var marketData = Synchronized([String: CoinMarketData]())
    
    init() {
        ratesCancellable = ratesUpdater.onUpdatePublisher
            .print()
            .sink(receiveValue: { [weak self] rates in
            guard let self = self else { return }
            self.currencyRates.writer({ (data) in
                data = rates.filter{$0.key != "BTC"}
            })
        })
    }
    
    deinit {
        ratesCancellable?.cancel()
    }

    func marketData(for coin: String) -> CoinMarketData {
        marketData.value[coin] ?? CoinMarketData()
    }

    func rate(for currency: FiatCurrency) -> Double {
        let code = currency.code
        return currencyRates.value[code] ?? 1.0
    }
}

