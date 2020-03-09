//
//  PieChartViewUIKitWrapper.swift
//  Portal
//
//  Created by Farid on 08.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI
import Charts

struct PieChartViewUIKitWrapper: UIViewRepresentable {
    let viewModel: PieChartViewModel

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

struct PieChartViewUIKitWrapper_Previews: PreviewProvider  {
    static var previews: some View {
        PieChartViewUIKitWrapper()
            .frame(width: UIScreen.main.bounds.width, height: 200, alignment: .center)
    }
}

