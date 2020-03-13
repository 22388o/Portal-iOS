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
    
    let topColor = Color(red: 0.0/255.0, green: 92.0/255.0, blue: 142.0/255.0)
    let bottomColor = Color(red: 85.0/255.0, green: 148.0/255.0, blue: 174.0/255.0)
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [topColor, bottomColor]), startPoint: .top, endPoint: .bottom)
            Color.black.opacity(0.58)
            
            VStack {
                
                AssetMarketValueView(type: .portfolio)
                            
                HStack(spacing: 50) {
                    VStack(spacing: 10) {
                        Text("Best performing")
                            .font(.custom("Avenir-Medium", size: 12))
                            .foregroundColor(Color.white.opacity(0.5))
                        Text("BTC")
                            .font(.custom("Avenir-Medium", size: 15))
                            .foregroundColor(Color.white.opacity(0.8))

                    }
                    
                    VStack(spacing: 10) {
                        Text("Worst performing")
                            .font(.custom("Avenir-Medium", size: 12))
                            .foregroundColor(Color.white.opacity(0.5))
                        Text("ETH")
                            .font(.custom("Avenir-Medium", size: 15))
                            .foregroundColor(Color.white.opacity(0.8))

                    }
                }
                .padding()
                
                Divider()
                    .background(Color.white.opacity(0.25))
                    .frame(width: UIScreen.main.bounds.width - 40)
                    .padding(2)
                
                VStack {
                    Text("Asset allocation")
                        .font(.custom("Avenir-Medium", size: 12))
                        .foregroundColor(Color.white.opacity(0.6))
                        .padding(2)
                    
                    AssetAllocationView(showTotalValue: false)
                        .frame(height: 150)
                }
                
            }
            .padding(6)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#if DEBUG
struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView(showModal: .constant(true))
    }
}
#endif
