//
//  CoinAdapter.swift
//  Portal
//
//  Created by Farid on 18.05.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import Foundation

struct CoinAdapter: Hashable, Identifiable {
    let id: String
    let asset: IAsset
    let viewModel: AssetItemViewModel

    init(asset: IAsset) {
        self.id = asset.coin.name
        self.asset = asset
        self.viewModel = AssetItemViewModel(asset: asset)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: CoinAdapter, rhs: CoinAdapter) -> Bool {
        lhs.id == rhs.id
    }
}
