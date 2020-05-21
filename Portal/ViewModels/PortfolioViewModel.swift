//
//  PortfolioViewModel.swift
//  Portal
//
//  Created by Farid on 19.05.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import Foundation
import Charts
import SwiftUI
import Combine

final class PortfolioViewModel: ObservableObject, IMarketDataMockable {
    var assets: [IAsset]
    private var marketData: [String : CoinMarketData]
    
    @Published var selectedTimeframe: Timeframe = .hour
    @Published var totalValue = String()
    @Published var chartDataEntries = [ChartDataEntry]()
    
    init(assets: [IAsset], marketData: [String : CoinMarketData]) {
        print("Portfolio view model init")
        
        self.assets = assets
        self.marketData = marketData
        self.marketData = mockedMarketData()
        
        totalValue = "$" + String(assets.map{ $0.balanceProvider.balance(currency: .usd) }.reduce(0){ $0 + $1 })
        chartDataEntries = portfolioChartDataEntries()
    }
    
    deinit {
        print("Portfolio view model deinit")
    }
            
    private func portfolioChartDataEntries() -> [ChartDataEntry] {
        var chartDataEntries = [ChartDataEntry]()
        let step = 8
        var valuesArray: [[Double]]

        switch selectedTimeframe {
        case .hour:
            valuesArray = assets.map{ $0.chartDataProvider.values(timeframe: selectedTimeframe, points: marketData["BTC"]?.hourPoints ?? []) }
        case .day:
            valuesArray = assets.map{ $0.chartDataProvider.values(timeframe: selectedTimeframe, points: marketData["BCH"]?.hourPoints ?? []) }
        case .week:
            valuesArray = assets.map{ $0.chartDataProvider.values(timeframe: selectedTimeframe, points: marketData["ETH"]?.hourPoints ?? []) }
        case .month:
            valuesArray = assets.map{ $0.chartDataProvider.values(timeframe: selectedTimeframe, points: marketData["BTC"]?.hourPoints ?? []) }
        case .year:
            valuesArray = assets.map{ $0.chartDataProvider.values(timeframe: selectedTimeframe, points: marketData["BTC"]?.hourPoints ?? []) }
        case .allTime: return [ChartDataEntry]()
        }

        guard var count = valuesArray.first?.count else { return [ChartDataEntry]() }

        if selectedTimeframe == .week || selectedTimeframe == .year { count = count/step + 1 }

        var resultArray: [Double] = Array(0..<count).map { x in 0 }

        for a in valuesArray {
            var array = a
            if selectedTimeframe == .week || selectedTimeframe == .year {
                array = a.enumerated().compactMap { $0.offset % step == 0 ? $0.element : nil }
            }
            for (index, value) in array.enumerated() {
                if resultArray.indices.contains(index) {
                    resultArray[index] = resultArray[index] + value
                }
            }
        }

        let xIndexes = Array(0..<resultArray.count).map { x in Double(x) }
        for (index, point) in resultArray.enumerated() {
            let dataEntry = ChartDataEntry(x: xIndexes[index], y: Double(point))
            chartDataEntries.append(dataEntry)
        }
        
        return chartDataEntries
    }
}
