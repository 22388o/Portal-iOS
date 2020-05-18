//
//  AssetAllocationViewModel.swift
//  Portal
//
//  Created by Farid on 09.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import Foundation
import Charts

struct AssetAllocationViewModel: IPieChartViewModelProtocol {
    var assets: [ICoinViewModel]
    
    init(assets: [ICoinViewModel] = WalletMock().assets.map{ $0.viewModel }) {
        self.assets = assets
    }
}
