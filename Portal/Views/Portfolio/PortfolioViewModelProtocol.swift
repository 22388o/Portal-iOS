//
//  PortfolioViewModelProtocol.swift
//  Portal
//
//  Created by Farid on 09.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import Foundation
import Charts

protocol PortfolioViewModelProtocol {
    var assets: [WalletItemViewModel] { get }
    var marketData: [String: CoinMarketData] { set get }
}

extension PortfolioViewModelProtocol {
    var selectedTimeframe: Timeframe { .hour }
    var marketData: [String: CoinMarketData] { [String: CoinMarketData]() }
    
    func portfolioChartDataEntries() -> [ChartDataEntry] {
        var chartDataEntries = [ChartDataEntry]()
        let step = 8
        var valuesArray: [[Double]]

        switch selectedTimeframe {
        case .hour:
            valuesArray = assets.map{ $0.values(timeframe: selectedTimeframe, points: marketData["BTC"]?.hourPoints ?? []) }
        case .day:
            valuesArray = assets.map{ $0.values(timeframe: selectedTimeframe, points: marketData["BTC"]?.hourPoints ?? []) }
        case .week:
            valuesArray = assets.map{ $0.values(timeframe: selectedTimeframe, points: marketData["BTC"]?.hourPoints ?? []) }
        case .month:
            valuesArray = assets.map{ $0.values(timeframe: selectedTimeframe, points: marketData["BTC"]?.hourPoints ?? []) }
        case .year:
            valuesArray = assets.map{ $0.values(timeframe: selectedTimeframe, points: marketData["BTC"]?.hourPoints ?? []) }
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
    
    func portfolioChartDataSet(entries: [ChartDataEntry]) -> LineChartDataSet {
        let ds = LineChartDataSet(values: entries, label: "")
        
        ds.colors = [
            UIColor(red: 19.0/255.0, green: 143.0/255.0, blue: 199.0/255.0, alpha: 1),
            UIColor(red: 17.0/255.0, green: 255.0/255.0, blue: 142.0/255.0, alpha: 1)
        ]
        
        ds.highlightEnabled = false
        ds.mode = .cubicBezier
        ds.drawHorizontalHighlightIndicatorEnabled = false
        
        ds.drawCirclesEnabled = false
        ds.lineWidth = 2.5
        
        let gradientColors = [
            UIColor(red: 0.0/255.0, green: 248.0/255.0, blue: 150.0/255.0, alpha: 0.6).cgColor,
            UIColor(red: 17.0/255.0, green: 83.0/255.0, blue: 79.0/255.0, alpha: 0.0).cgColor
            ] as CFArray
        
        let colorLocations: [CGFloat] = [1.0, 0.0]
        
        let gradiendFillColor = CGGradient.init(
            colorsSpace: CGColorSpaceCreateDeviceRGB(),
            colors: gradientColors,
            locations: colorLocations
            )!
                
        ds.fill = Fill.fillWithLinearGradient(gradiendFillColor, angle: 90.0)
        ds.drawFilledEnabled = true
        
        ds.isDrawLineWithGradientEnabled = true
                
        return ds
    }
    
    mutating func mockHourData() {
        let assetsSymbols = "BTC,BCH,ETH,XLM,XTZ"
        if let responseData = hourDataResponse.data(using: .utf8) {
            do {
                let unfilteredData = try JSONDecoder().decode([String:[MarketSnapshot]].self, from: responseData)
                let filteredData = filteredDict(unfilteredData)
                var hasData: Bool = false
                for hourPoints in filteredData {
                    if marketData[hourPoints.key] == nil {
                        marketData[hourPoints.key] = CoinMarketData()
                    }
                    marketData[hourPoints.key]?.hourPoints = hourPoints.value
                    hasData = true
                }
                marketData[assetsSymbols]?.hasData = hasData
            } catch {
                print("\(#function) error: \(error)")
            }
        }
    }
    
    private func filteredDict(_ initialDictionary: [String:[MarketSnapshot]]) -> [String:[MarketSnapshot]] {
        //filtered out empty values from cryptomarket
        var filteredDictionary: [String:[MarketSnapshot]] = [:]
        for dictionary in initialDictionary {
            filteredDictionary[dictionary.key] = dictionary.value.filter{$0.open > 0 && $0.close > 0}
        }
        return filteredDictionary
    }
}
