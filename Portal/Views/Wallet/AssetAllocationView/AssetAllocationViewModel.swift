//
//  AssetAllocationViewModel.swift
//  Portal
//
//  Created by Farid on 09.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import Foundation
import Charts

struct AssetAllocationViewModel: PieChartViewModelProtocol {
    var assets: [WalletItemViewModel]
    
    init(assets: [WalletItemViewModel]) {
        self.assets = assets
    }
}
