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
    @Binding var chartDataEntries: [ChartDataEntry]
    
    func makeUIView(context: Context) -> LineChartView {
        let lineChart = LineChartView()
        lineChart.applyStandardSettings()
                
        updateChartData(lineChart: lineChart)
        
        return lineChart
    }

    func updateUIView(_ lineChart: LineChartView, context: Context) {
        updateChartData(lineChart: lineChart)
    }
    
    func updateChartData(lineChart: LineChartView) {
        let data = LineChartData()
        let dataSet = chartDataEntries.dataSet()
        
        data.dataSets = [dataSet]
                
        let maxValue = chartDataEntries.map{$0.y}.max()
        
        if maxValue != nil {
            dataSet.gradientPositions = [0, CGFloat(maxValue!)]
            lineChart.data = data
            lineChart.notifyDataSetChanged()
        }
    }
}

#if DEBUG
struct LineChartUIKitWrapper_Previews: PreviewProvider {
    static var previews: some View {
        LineChartUIKitWrapper(
            chartDataEntries: .constant([])
        )
            .frame(width: UIScreen.main.bounds.width, height: 150)
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .background(Color.portalBackground.edgesIgnoringSafeArea(.all))
    }
}
#endif
