//
//  WalletView.swift
//  Portal
//
//  Created by Farid on 06.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI
import QGrid

protocol Asset {
    var viewModel: CoinViewModel { get }
}

protocol Wallet {
    var assets: [Asset] { get }
}

struct CoinAdapter: Identifiable {
    let id: String
    let coin: CoinViewModel

    init(coin: CoinViewModel) {
        self.id = coin.name
        self.coin = coin
    }
}

struct WalletView: View {
    @State private var showPortfolioView = false
    @State private var showCoinView = false
    
    @State private var curentItem: CoinViewModel = CoinMock() {
        didSet {
            showCoinView.toggle()
        }
    }
    
    private var viewModels: [CoinViewModel]
    
    init(wallet: Wallet = WalletMock()) {
        viewModels = wallet.assets.map{ $0.viewModel }
    }
    
    var body: some View {
        ZStack {
            Color.portalBackground.edgesIgnoringSafeArea(.all)
            
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
                
                QGrid(viewModels.map{ CoinAdapter(coin: $0) }, columns: 1) { adapter in
                    WalletItemView(viewModel: adapter.coin)
                        .onTapGesture {
                            self.curentItem = adapter.coin
                    }
                }
                .padding(.bottom, -10)
                .sheet(isPresented: self.$showCoinView) {
                    CoinView(model: self.$curentItem)
                }
            }
        }
    }
}

#if DEBUG
struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView(wallet: WalletMock())
    }
}
#endif
