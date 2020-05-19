//
//  WalletView.swift
//  Portal
//
//  Created by Farid on 06.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI
import QGrid

struct WalletView: View {
    @State private var showPortfolioView = false
    @State private var showCoinView = false
    
    @State private var selectedAsset: IAsset = Asset(coin: Coin(code: "ETH", name: "Ethereum")) {
        didSet {
            showCoinView.toggle()
        }
    }
    
    @ObservedObject var viewModel: WalletViewModel
    
    init(walletCoordinator: WalletCoordinator) {
        viewModel = .init(wallet: walletCoordinator.$currentWallet)
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
                QGrid(viewModel.assets.map{ CoinAdapter(asset: $0) }, columns: 1) { adapter in
                    WalletItemView(asset: adapter.asset)
                        .onTapGesture {
                            self.selectedAsset = adapter.asset
                    }
                }
                .padding(.bottom, -10)
                .sheet(isPresented: self.$showCoinView) {
                    CoinView(asset: self.$selectedAsset)
                }
            }
        }
    }
}

#if DEBUG
struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView(walletCoordinator: WalletCoordinator(mockedWallet: WalletMock()))
    }
}
#endif
