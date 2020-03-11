//
//  LineChartUIKitWrapper.swift
//  Portal
//
//  Created by Farid on 09.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI
import Charts

struct LineChartUIKitWrapper: UIViewRepresentable {
    
    let viewModel: PortfolioViewModel
    
    init(viewModel: PortfolioViewModel = PortfolioViewModel()) {
        self.viewModel = viewModel
    }
    
    func makeUIView(context: Context) -> LineChartView {
        let lineChart = LineChartView()
        lineChart.applyStandardSettings()
        
        let entries = viewModel.portfolioChartDataEntries()
        
        let data = LineChartData()
        let dataSet = viewModel.portfolioChartDataSet(entries: entries)
        
        data.dataSets = [dataSet]
                
        let maxValue = entries.map{$0.y}.max()
        
        if maxValue != nil {
            dataSet.gradientPositions = [0, CGFloat(maxValue!)]
            lineChart.data = data
            lineChart.notifyDataSetChanged()
        }
        
        return lineChart
    }

    func updateUIView(_ uiView: LineChartView, context: Context) {}
}

#if DEBUG
struct LineChartUIKitWrapper_Previews: PreviewProvider {
    static var previews: some View {
        LineChartUIKitWrapper()
            .frame(width: UIScreen.main.bounds.width, height: 150)
    }
}
#endif
