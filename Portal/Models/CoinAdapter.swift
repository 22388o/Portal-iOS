//
//  CoinAdapter.swift
//  Portal
//
//  Created by Farid on 18.05.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import Foundation

struct CoinAdapter: Identifiable {
    let id: String
    let asset: IAsset

    init(asset: IAsset) {
        self.id = asset.viewModel.name
        self.asset = asset
    }
}
