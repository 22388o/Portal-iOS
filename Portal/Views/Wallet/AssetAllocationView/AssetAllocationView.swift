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
    
    init(viewModel: AssetAllocationViewModel = AssetAllocationViewModel(assets: WalletMock)) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            Text("$" + String(viewModel.totalPortfolioValue)).font(.body)
            PieChartViewUIKitWrapper(viewModel: viewModel)
        }
    }
}

struct AssetAllocationView_Previews: PreviewProvider {
    static var previews: some View {
        AssetAllocationView()
            .frame(width: UIScreen.main.bounds.width, height: 200)
    }
}
