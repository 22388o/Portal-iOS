//
//  WalletView.swift
//  Portal
//
//  Created by Farid on 06.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct WalletView: View {
    @State private var showPortfolioView = false
    @State private var showCoinView = false
    
    @State private var curentItem: WalletItemViewModel = CoinMock() {
        didSet {
            showCoinView.toggle()
        }
    }
    
    private var viewModels: [WalletItemViewModel]
    
    init(wallet: [WalletItemViewModel] = WalletMock) {
        viewModels = wallet
    }
    
    var body: some View {
        VStack(spacing: 20) {
            AssetAllocationView()
                .frame(width: UIScreen.main.bounds.width, height: 180.0)
                .padding(.bottom, -20)
                .onTapGesture {
                self.showPortfolioView.toggle()
            }
            .sheet(isPresented: $showPortfolioView) {
                PortfolioView(showModal: self.$showPortfolioView)
            }
            
            List(0 ..< viewModels.count) { index in
                WalletItemView(viewModel: self.viewModels[index])
                    .onTapGesture {
                        self.curentItem = self.viewModels[index]
                }
            }
            .padding(.top, -10)
            .sheet(isPresented: self.$showCoinView) {
                CoinView(model: self.$curentItem)
            }
        }
    }
}

#if DEBUG
struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView(wallet: WalletMock)
    }
}
#endif
