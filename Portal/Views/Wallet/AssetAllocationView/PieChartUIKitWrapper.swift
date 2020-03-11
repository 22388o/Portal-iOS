//
//  PieChartUIKitWrapper.swift
//  Portal
//
//  Created by Farid on 08.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI
import Charts

struct PieChartUIKitWrapper: UIViewRepresentable {
    let viewModel: PieChartViewModelProtocol

    init(viewModel: AssetAllocationViewModel = AssetAllocationViewModel(assets: WalletMock)) {
        self.viewModel = viewModel
    }
    
    func makeUIView(context: Context) -> PieChartView {
        let pieChart = PieChartView()
        pieChart.applyStandardSettings()
        pieChart.data = viewModel.assetAllocationChartData()
        return pieChart
    }

    func updateUIView(_ uiView: PieChartView, context: Context) {}
}

#if DEBUG
struct PieChartUIKitWrapper_Previews: PreviewProvider  {
    static var previews: some View {
        PieChartUIKitWrapper()
            .frame(width: UIScreen.main.bounds.width, height: 200, alignment: .center)
    }
}
#endif

