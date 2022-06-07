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
        assets: [IAsset],
        showTotalValue: Bool = true
    ) {
        self.viewModel = AssetAllocationViewModel(assets: assets)
        self.showTotalValue = showTotalValue
    }
    
    var body: some View {
        ZStack {
            if showTotalValue {
                Text("$" + "\(viewModel.totalPortfolioValue)")
                    .font(Font.mainFont(size: 16))
                    .foregroundColor(Color.white)
            }
            PieChartUIKitWrapper(viewModel: viewModel)
        }
    }
}

#if DEBUG
struct AssetAllocationView_Previews: PreviewProvider {
    static var previews: some View {
        AssetAllocationView(
            assets: WalletMock().assets,
            showTotalValue: true
        )
        .frame(height: 200)
        .previewLayout(PreviewLayout.sizeThatFits)
        .padding()
        .background(Color.portalBackground.edgesIgnoringSafeArea(.all))
    }
}
#endif
