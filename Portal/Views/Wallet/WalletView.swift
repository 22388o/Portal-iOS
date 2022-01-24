//
//  WalletView.swift
//  Portal
//
//  Created by Farid on 06.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct WalletView: View {
    
    private let verticalSpacing: CGFloat = 20
    private let assetAllocationViewHeight: CGFloat = 180
    private let assetAllocationViewBottomOffset: CGFloat = -20
    private let listSideOffset: CGFloat = -10
    private let listBottomOffset: CGFloat = -2.5
    
    @ObservedObject private var viewModel: WalletViewModel
        
    init(wallet: IWallet = WalletMock()) {
        print("WalletView init")
        self.viewModel = .init(assets: wallet.assets)
    }
    
    var body: some View {
        ZStack {
            Color.portalBackground.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: verticalSpacing) {
                AssetAllocationView(assets: viewModel.adapters.map{$0.asset})
                    .frame(width: UIScreen.main.bounds.width, height: assetAllocationViewHeight)
                    .padding(.bottom, assetAllocationViewBottomOffset)
                    .onTapGesture {
                        self.viewModel.showPortfolioView.toggle()
                }
                    .sheet(isPresented: $viewModel.showPortfolioView) {
                        PortfolioView(assets: self.viewModel.adapters.map{$0.asset})
                    }
                List(viewModel.adapters) { adapter in
                    AssetItemView(adapter.viewModel)
                        .onTapGesture {
                            self.viewModel.selectedAdapter = adapter
                    }
                    .listRowBackground(Color.clear)

                }
                .padding([.leading, .trailing], self.listSideOffset)
                .padding(.bottom, self.listBottomOffset)
                    .sheet(isPresented: self.$viewModel.showCoinView) {
                        AssetView(asset: self.viewModel.selectedAdapter.asset)
                    }
            }
        }
    }
}

#if DEBUG
struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WalletView(wallet: WalletMock())
                .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
                .previewDisplayName("iPhone 11 Pro")
            
            WalletView(wallet: WalletMock())
                .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
                .previewDisplayName("iPhone 11 Pro Max")
            
            WalletView(wallet: WalletMock())
                .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
                .previewDisplayName("iPhone SE")
        }
    }
}
#endif
