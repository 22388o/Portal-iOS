//
//  AssetAllocationView.swift
//  Portal
//
//  Created by Farid on 09.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct AssetAllocationView: View {
    let viewModel: AssetAllocationViewModel
    let showTotalValue: Bool
    
    init(
        viewModel: AssetAllocationViewModel = AssetAllocationViewModel(assets: WalletMock),
        showTotalValue: Bool = true
    ) {
        self.viewModel = viewModel
        self.showTotalValue = showTotalValue
    }
    
    var body: some View {
        ZStack {
            if showTotalValue {
                Text("$" + String(viewModel.totalPortfolioValue)).font(.body)
            }
            PieChartUIKitWrapper(viewModel: viewModel)
        }
    }
}

struct AssetAllocationView_Previews: PreviewProvider {
    static var previews: some View {
        AssetAllocationView()
            .frame(height: 200)
    }
}
