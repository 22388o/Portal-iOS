//
//  PortfolioViewModel.swift
//  Portal
//
//  Created by Farid on 19.05.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import Foundation

struct PortfolioViewModel: IPortfolio {
    var wallet: IWallet
    var marketData: [String : CoinMarketData]
    
    init(wallet: IWallet, marketData: [String : CoinMarketData]) {
        self.wallet = wallet
        self.marketData = marketData
        self.mockHourData()
    }
}
