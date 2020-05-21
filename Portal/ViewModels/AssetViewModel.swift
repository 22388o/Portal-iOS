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

final class AssetViewModel: ObservableObject, MarketDataMockable {
    var asset: IAsset
    
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
    @Published var selectedTimeframe: Timeframe = .hour
    
    @Published var chartDataEntries = [ChartDataEntry]()
        
    init(asset: IAsset) {
        print("Init \(asset.coin.code) viewModel")
        self.asset = asset
        
        code = asset.coin.code
        name = asset.coin.name
        icon = asset.coin.icon
        
        self.asset.marketData = mockedMarketData()["BTC"] ?? CoinMarketData()
        self.chartDataEntries = portfolioChartDataEntries()
        
        updateValues()
    }
    
    deinit {
        print("Deinit \(code) viewModel")
    }
    
    private func updateValues() {
        print("Value updated")
        balance = asset.balanceProvider.balanceString //+ "\(Int.random(in: 1...8))"
        totalValue = asset.balanceProvider.totalValueString //+ "\(Int.random(in: 1...8))"
        price = asset.balanceProvider.price //+ "\(Int.random(in: 1...8))"
        change = asset.marketChangeProvider.changeString //+ "\(Int.random(in: 1...8))"
    }
    
    private func portfolioChartDataEntries() -> [ChartDataEntry] {
        var chartDataEntries = [ChartDataEntry]()
        var points = [MarketSnapshot]()
        
        let step = 4
        
        switch selectedTimeframe {
        case .hour: points = asset.marketData.hourPoints
        case .day: points = asset.marketData.dayPoints
        case .week: points = asset.marketData.weekPoints.enumerated().compactMap { $0.offset % step == 0 ? $0.element : nil }
        case .month: points = asset.marketData.monthPoints
        case .year: points = asset.marketData.yearPoints.enumerated().compactMap { $0.offset % step == 0 ? $0.element : nil }
        case .allTime: return []
        }
        
        let xIndexes = Array(0..<points.count).map { x in Double(x) }
        for (index, point) in points.enumerated() {
            let dataEntry = ChartDataEntry(x: xIndexes[index], y: Double(point.close))
            chartDataEntries.append(dataEntry)
        }
        
        return chartDataEntries
    }
}
