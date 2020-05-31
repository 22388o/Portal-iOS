//
//  PortfolioView.swift
//  Portal
//
//  Created by Farid on 06.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct PortfolioView: View {
    @ObservedObject var viewModel: PortfolioViewModel
    
    init(assets: [IAsset]) {
        print("Portfolio init")
        self.viewModel = .init(assets: assets)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                    Color.portalBackground
                    
                    VStack {
                        
                        MarketValueView(
                            timeframe: self.$viewModel.selectedTimeframe,
                            totalValue: self.$viewModel.totalValue,
                            change: self.$viewModel.change,
                            chartDataEntries: self.$viewModel.chartDataEntries,
                            valueCurrencyViewSate: self.$viewModel.valueCurrencySwitchState
                        ).padding(.top, 10)
                                
                        if geometry.size.height > 700 {
                            HStack(spacing: 50) {
                                VStack(spacing: 10) {
                                    Text("Best performing")
                                        .font(Font.mainFont())
                                        .foregroundColor(Color.white.opacity(0.5))
                                    Text("BTC")
                                        .font(Font.mainFont(size: 15))
                                        .foregroundColor(Color.white.opacity(0.8))

                                }
                                
                                VStack(spacing: 10) {
                                    Text("Worst performing")
                                        .font(Font.mainFont())
                                        .foregroundColor(Color.white.opacity(0.5))
                                    Text("ETH")
                                        .font(Font.mainFont(size: 15))
                                        .foregroundColor(Color.white.opacity(0.8))

                                }
                            }
                            .padding()
                        }
                        
                        Divider()
                            .background(Color.white.opacity(0.25))
                            .frame(width: UIScreen.main.bounds.width - 40)
                            .padding(2)
                        
                        VStack {
                            Text("Asset allocation")
                                .font(Font.mainFont())
                                .foregroundColor(Color.white.opacity(0.6))
                                .padding(2)
                            
                            AssetAllocationView(assets: self.viewModel.assets, showTotalValue: false)
                                .frame(height: 150)
                        }
                        
                    }
                    .padding(6)
                    .onAppear {
                        print("On appear")
                    }.onDisappear {
                        print("On dissapear")
                    }
                }
                .edgesIgnoringSafeArea(.all)
            }
        }
}

#if DEBUG
struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PortfolioView(assets: WalletMock().assets)
                .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
                .previewDisplayName("iPhone SE")
            
            PortfolioView(assets: WalletMock().assets)
                .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
                .previewDisplayName("iPhone 11 Pro")
            
            PortfolioView(assets: WalletMock().assets)
                .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
                .previewDisplayName("iPhone 11 Pro Max")
        }
    }
}
#endif
