//
//  WalletView.swift
//  Portal
//
//  Created by Farid on 06.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct WalletView: View {
    @State private var showPortfolio = false
    
    let viewModels: [WalletItemViewModel] = [
        BTC(),
        ETH(),
        CoinMock(),
        BTC(),
        ETH()
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            PieChartView()
                .padding(.all, 80)
                .onTapGesture {
                    self.showPortfolio.toggle()
            }
            
            List(0 ..< viewModels.count) { index in
                WalletItemView(viewModel: self.viewModels[index]).onTapGesture {
                    self.showPortfolio.toggle()
                }
            }
        }.sheet(isPresented: $showPortfolio) {
            PortfolioView(showModal: self.$showPortfolio)
        }
    }
}

struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView()
    }
}
