//
//  AssetAllocationViewModel.swift
//  Portal
//
//  Created by Farid on 09.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import Foundation
import Charts

struct AssetAllocationViewModel: IPieChartModel {
    var assets: [IAsset]
    
    init(assets: [IAsset] = WalletMock().assets.map{ $0 }) {
        print("Asset allocation view model init")
        self.assets = assets
    }
}
