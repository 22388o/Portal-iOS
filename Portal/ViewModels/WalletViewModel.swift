//
//  WalletViewModel.swift
//  Portal
//
//  Created by Farid on 18.05.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import Foundation
import Combine

final class WalletViewModel: ObservableObject {
//    private var subscription: AnyCancellable?
    
    @Published var adapters: [CoinAdapter]
    
    @Published var showPortfolioView = false
    @Published var showCoinView = false
    
    @Published var selectedAdapter = CoinAdapter(asset: Asset(coin: Coin(code: "BTC", name: "Bitcoin"))) {
        didSet {
            showCoinView.toggle()
        }
    }
    
    init(assets: [IAsset]) {
        print("WalletViewModel init")
        self.adapters = assets.map{ CoinAdapter(asset: $0) }
//        self.viewModels = self.assets.map{ AssetItemViewModel(asset: $0) }
//        subscription = wallet
//            .unwrap()
//            .sink { [weak self] currentWallet in
//                self?.assets = currentWallet.assets
//            }
    }
}
