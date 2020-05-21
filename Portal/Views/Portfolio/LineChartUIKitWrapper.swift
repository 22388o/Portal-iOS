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
    
    let chartDataEntries: [ChartDataEntry]
    
    init(chartDataEntries: [ChartDataEntry]) {
        self.chartDataEntries = chartDataEntries
    }
    
    func makeUIView(context: Context) -> LineChartView {
        let lineChart = LineChartView()
        lineChart.applyStandardSettings()
                
        let data = LineChartData()
        let dataSet = chartDataEntries.dataSet()
        
        data.dataSets = [dataSet]
                
        let maxValue = chartDataEntries.map{$0.y}.max()
        
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
        LineChartUIKitWrapper(chartDataEntries: [])
            .frame(width: UIScreen.main.bounds.width, height: 150)
    }
}
#endif
