//
//  PortfolioView.swift
//  Portal
//
//  Created by Farid on 06.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct PortfolioViewModel: PortfolioViewModelProtocol {
    var marketData: [String : CoinMarketData]
    var assets: [WalletItemViewModel]
    
    init(marketData: [String : CoinMarketData] = [String : CoinMarketData](), assets: [WalletItemViewModel] = WalletMock) {
        self.marketData = marketData
        self.assets = assets
        self.mockHourData()
    }
}

struct PortfolioView: View {
    @Binding var showModal: Bool
    
    let viewModel: PortfolioViewModel = PortfolioViewModel()
    
    var body: some View {
        VStack {
            
            AssetMarketValueView()
                        
            HStack(spacing: 20) {
                VStack(spacing: 10) {
                    Text("Best performing")
                    Text("BTC")
                }
                
                VStack(spacing: 10) {
                    Text("Worst performing")
                    Text("ETH")
                }
            }
            .padding()
            
            Divider()
                .padding(2)
            
            VStack {
                Text("Asset allocation")
                    .font(.headline)
                    .padding(2)
                
                AssetAllocationView(showTotalValue: false)
                    .frame(height: 150)
            }
            
        }
        .padding(6)
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView(showModal: .constant(true))
    }
}
