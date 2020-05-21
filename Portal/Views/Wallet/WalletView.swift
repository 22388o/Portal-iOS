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
    @ObservedObject var viewModel: WalletViewModel
        
    init(wallet: IWallet = WalletMock()) {
        print("WalletView init")
        viewModel = .init(assets: wallet.assets)
    }
    
    var body: some View {
        ZStack {
            Color.portalBackground.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                AssetAllocationView(assets: viewModel.adapters.map{$0.asset})
                    .frame(width: UIScreen.main.bounds.width, height: 180.0)
                    .padding(.bottom, -20)
                    .onTapGesture {
                        self.viewModel.showPortfolioView.toggle()
                }
                .sheet(isPresented: $viewModel.showPortfolioView) {
                    PortfolioView(assets: self.viewModel.adapters.map{$0.asset})
                }
                QGrid(viewModel.adapters, columns: 1) { adapter in
                    AssetItemView(viewModel: adapter.viewModel)
                        .onTapGesture {
                            self.viewModel.selectedAsset = adapter.asset
                    }
                }
                .padding(.bottom, -10)
                .sheet(isPresented: self.$viewModel.showCoinView) {
                    AssetView(asset: self.viewModel.selectedAsset)
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
