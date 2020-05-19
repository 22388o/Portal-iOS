//
//  Asset.swift
//  Portal
//
//  Created by Farid on 19.05.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import Foundation

final class TxProvider: ITxProvider {
    let coin: Coin
    let kit: ICoinKit
    
    init(coin: Coin, kit: ICoinKit) {
        self.coin = coin
        self.kit = kit
    }
}
protocol ITxProvider {}



final class Asset: IAsset {
    var coin: Coin
    var kit: ICoinKit
    var marketData: CoinMarketData
    var balanceProvider: IBalanceProvider
    var chartDataProvider: IChartDataProvider
    var marketChangeProvider: IMarketChangeProvider
    var qrCodeProvider: IQRCodeProvider

    init(coin: Coin, data: Data = Data(), kit: ICoinKit = MockCoinKit()) {
        self.coin = coin
        self.kit = kit
        self.marketData = CoinMarketData()
        self.balanceProvider = BalanceProvider(coin: coin, kit: kit)
        self.chartDataProvider = ChartDataProvider()
        self.marketChangeProvider = MarketChangeProvider()
        self.qrCodeProvider = QRCodeProvider()
    }
}
