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

final class PortfolioViewModel: ObservableObject, IMarketData {
    var assets: [IAsset]
//    private var marketData: [String : CoinMarketData]
    
    @Published var selectedTimeframe: Timeframe = .hour
    @Published var totalValue = String()
    @Published var change: String = "-$423 (3.46%)"
    @Published var chartDataEntries = [ChartDataEntry]()
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(assets: [IAsset]) {
        print("Portfolio view model init")
        
        self.assets = assets
//        self.marketData = marketData
//        self.marketData = mockedMarketData()
        
        let currency: Currency = .fiat(USD)
        
        totalValue = "$" + String(assets.map{ $0.balanceProvider.balance(currency: currency) }.reduce(0){ $0 + $1 }.rounded(toPlaces: 2))
        
        $selectedTimeframe
        .removeDuplicates()
        .sink { [weak self] timeframe in
            self?.selectedTimeframe = timeframe
            self?.updateCharts()
        }
        .store(in: &subscriptions)
    }
    
    deinit {
        print("Portfolio view model deinit")
    }
    
    private func updateCharts() {
        chartDataEntries = portfolioChartDataEntries()
    }
            
    private func portfolioChartDataEntries() -> [ChartDataEntry] {
        var chartDataEntries = [ChartDataEntry]()
        let step = 8
        var valuesArray: [[Double]]

        switch selectedTimeframe {
        case .hour:
            valuesArray = assets.map {
                $0.chartDataProvider.values(timeframe: selectedTimeframe, points: marketData(for: $0.coin.code).hourPoints)
            }
        case .day:
            valuesArray = assets.map {
                $0.chartDataProvider.values(timeframe: selectedTimeframe, points: marketData(for: $0.coin.code).dayPoints)
            }
        case .week:
            valuesArray = assets.map {
                $0.chartDataProvider.values(timeframe: selectedTimeframe, points: marketData(for: $0.coin.code).weekPoints)
            }
        case .month:
            valuesArray = assets.map {
                $0.chartDataProvider.values(timeframe: selectedTimeframe, points: marketData(for: $0.coin.code).monthPoints)
            }
        case .year:
            valuesArray = assets.map {
                $0.chartDataProvider.values(timeframe: selectedTimeframe, points: marketData(for: $0.coin.code).yearPoints)
            }
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
