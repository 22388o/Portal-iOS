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
            Text("Total portfolio value")
                .font(.headline)
                .padding()
            HStack(spacing: 20) {
                Button(action: {
                    
                }) { Text("Hour") }
                Button(action: {
                    
                }) { Text("Day") }
                Button(action: {
                    
                }) { Text("Week") }
                Button(action: {
                    
                }) { Text("Month") }
                Button(action: {
                    
                }) { Text("Year") }
                Button(action: {
                    
                }) { Text("All time") }
            }
            
            Spacer()
                .frame(height: 20)
            
            HStack {
                VStack {
                    Text(viewModel.totalValue).font(.largeTitle)
                    Text("Change")
                }
            }
            
            LineChartUIKitWrapper()
                .frame(height: 150)
            
            Spacer()
                .frame(height: 50)
            
            VStack(spacing: 40) {
                HStack(spacing: 80) {
                    VStack(spacing: 10) {
                        Text("High")
                        Text("$0.0")
                    }
                    VStack(spacing: 10) {
                        Text("Low")
                        Text("$0.0")
                    }
                }
                
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
            }
            
            Spacer()
                .frame(height: 60)
            
            Text("Asset allocation")
                .font(.headline)
            
            AssetAllocationView(showTotalValue: false)
                .frame(height: 150)
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView(showModal: .constant(true))
    }
}
