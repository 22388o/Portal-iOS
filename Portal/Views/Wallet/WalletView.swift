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
    @State private var showCoinDetails = false
    
    private var viewModels: [WalletItemViewModel]
    
    init(wallet: [WalletItemViewModel] = WalletMock) {
        viewModels = wallet
    }
    
    var body: some View {
        VStack(spacing: 20) {
            PieChartView().padding(.all, 100).onTapGesture {
                self.showPortfolio.toggle()
            }.sheet(isPresented: $showPortfolio) {
                PortfolioView(showModal: self.$showPortfolio)
            }
            
            List(0 ..< viewModels.count) { index in
                WalletItemView(viewModel: self.viewModels[index]).onTapGesture {
                    self.showCoinDetails.toggle()
                }.sheet(isPresented: self.$showCoinDetails) {
                    CoinDetailsView(showModal: self.$showCoinDetails)
                }
            }
        }
    }
}

struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView(wallet: WalletMock)
    }
}
