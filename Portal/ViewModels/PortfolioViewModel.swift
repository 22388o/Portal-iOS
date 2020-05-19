//
//  PortfolioViewModel.swift
//  Portal
//
//  Created by Farid on 19.05.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import Foundation

struct PortfolioViewModel: IPortfolio {
    var assets: [IAsset]
    var marketData: [String : CoinMarketData]
    
    init(assets: [IAsset], marketData: [String : CoinMarketData]) {
        self.assets = assets
        self.marketData = marketData
        self.mockHourData()
    }
}
