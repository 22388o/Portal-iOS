//
//  AssetViewModel.swift
//  Portal
//
//  Created by Farid on 21.05.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
import Charts

final class AssetViewModel: ObservableObject, IMarketData {
    public var asset: IAsset
    
    let code: String
    let name: String
    let icon: UIImage
        
    @Published var balance = String()
    @Published var totalValue = String()
    @Published var price = String()
    @Published var change = String()
    
    @Published var showSendView = false
    @Published var showReceiveView = false
    @Published var showSendToExchangeView = false
    @Published var showWithdrawView = false
    @Published var route: CoinViewRoute = .value
    @Published var selectedTimeframe: Timeframe = .day
    
    @Published var chartDataEntries = [ChartDataEntry]()
    @Published var currency: Currency = .fiat(USD)
    @Published var valueCurrencySwitchState: ValueCurrencySwitchState = .fiat
    
    private var subscriptions = Set<AnyCancellable>()
            
    var marketData: CoinMarketData {
        marketData(for: code)
    }
    
    var rate: Double {
        marketRate(for: USD)
    }
    
    init(asset: IAsset) {
        print("Init \(asset.coin.code) viewModel")
        self.asset = asset
        
        code = asset.coin.code
        name = asset.coin.name
        icon = UIImage(imageLiteralResourceName: "iconBtc")
                
        $selectedTimeframe
            .removeDuplicates()
            .sink { [weak self] timeframe in
                self?.selectedTimeframe = timeframe
                self?.updateValues()
            }
            .store(in: &subscriptions)
        
        $valueCurrencySwitchState.sink { state in
            switch state {
            case .fiat:
                self.totalValue = asset.balanceProvider.totalValueString
            case .btc:
                self.totalValue = "0.0224 BTC"
            case .eth:
                self.totalValue = "1.62 ETH"
            }
        }
        .store(in: &subscriptions)
    }
    
    deinit {
        print("Deinit \(code) viewModel")
    }
    
    private func updateValues() {
        print("Value updated")
        balance = asset.balanceProvider.balanceString
        totalValue = asset.balanceProvider.totalValueString
        price = asset.balanceProvider.price
        change = asset.marketChangeProvider.changeString
        chartDataEntries = portfolioChartDataEntries()
    }
    
    private func portfolioChartDataEntries() -> [ChartDataEntry] {
        var chartDataEntries = [ChartDataEntry]()
        var points = [PricePoint]()
        
        let step = 4
        
        switch selectedTimeframe {
        case .day:
            points = marketData.dayPoints
        case .week:
            points = marketData.weekPoints.enumerated().compactMap {
                $0.offset % step == 0 ? $0.element : nil
            }
        case .month:
            points = marketData.monthPoints
        case .year:
            points = marketData.yearPoints.enumerated().compactMap {
                $0.offset % step == 0 ? $0.element : nil
            }
        }
        
        let xIndexes = Array(0..<points.count).map { x in Double(x) }
        for (index, point) in points.enumerated() {
            let dataEntry = ChartDataEntry(x: xIndexes[index], y: point.price.double)
            chartDataEntries.append(dataEntry)
        }
        
        return chartDataEntries
    }
}
