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
    }
}
