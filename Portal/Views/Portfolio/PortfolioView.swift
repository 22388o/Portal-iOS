//
//  PortfolioView.swift
//  Portal
//
//  Created by Farid on 06.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct PortfolioView: View {
    @Binding var showModal: Bool
        
    let viewModel: PortfolioViewModel = PortfolioViewModel(
        wallet: WalletMock(),
        marketData: [String : CoinMarketData]()
    )
    
    var body: some View {
        ZStack {
            Color.portalBackground
            
            VStack {
                
                AssetMarketValueView(type: .portfolio, viewModel: viewModel)
                            
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
                
                Divider()
                    .background(Color.white.opacity(0.25))
                    .frame(width: UIScreen.main.bounds.width - 40)
                    .padding(2)
                
                VStack {
                    Text("Asset allocation")
                        .font(Font.mainFont())
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
