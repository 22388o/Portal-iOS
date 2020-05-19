//
//  Asset.swift
//  Portal
//
//  Created by Farid on 19.05.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import Foundation

final class Asset: IAsset {
    var coin: Coin
    var coinKit: ICoinKit
    var marketData: CoinMarketData
    var balanceProvider: IBalanceProvider
    var chartDataProvider: IChartDataProvider
    var marketChangeProvider: IMarketChangeProvider
    var qrCodeProvider: IQRCodeProvider

    init(coin: Coin, data: Data = Data()) {
        self.coin = coin
        self.coinKit = MockCoinKit()
        self.marketData = CoinMarketData()
        self.balanceProvider = BalanceProvider(coin: self.coin, kit: self.coinKit)
        self.chartDataProvider = ChartDataProvider()
        self.marketChangeProvider = MarketChangeProvider()
        self.qrCodeProvider = QRCodeProvider()
    }
}
