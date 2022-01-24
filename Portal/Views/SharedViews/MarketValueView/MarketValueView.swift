//
//  MarketValueView.swift
//  Portal
//
//  Created by Farid on 10.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI
import Charts

struct MarketValueView: View {
    @Binding var timeframe: Timeframe
    @Binding var totalValue: String
    @Binding var change: String
    @Binding var chartDataEntries: [ChartDataEntry]
    @Binding var valueCurrencyViewSate: ValueCurrencySwitchState
    
    @State private var type: AssetMarketValueViewType = .portfolio
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    private func body(for size: CGSize) -> some View {
        VStack {
            TimeframeButtonsView(type: $type, timeframe: $timeframe)
            
            MarketValueControlsView(
                valueCurrencyViewSate: $valueCurrencyViewSate,
                change: $change,
                totalValue: $totalValue,
                type: $type
            )
            
            LineChartUIKitWrapper(chartDataEntries: $chartDataEntries)
                .frame(height: size.height > 500 ? 250 : 150)
                .padding([.leading, .trailing])
            
            HStack(spacing: 80) {
                VStack(spacing: 10) {
                    Text("High")
                        .font(Font.mainFont())
                        .foregroundColor(type == .asset ? Color.lightActiveLabel.opacity(0.5) : Color.white.opacity(0.5))
                    Text("$0.0")
                        .font(Font.mainFont(size: 15))
                        .foregroundColor(type == .asset ? Color.lightActiveLabel.opacity(0.8) : Color.white.opacity(0.8))
                }
                .padding()
                
                VStack(spacing: 10) {
                    Text("Low")
                        .font(Font.mainFont())
                        .foregroundColor(type == .asset ? Color.lightActiveLabel.opacity(0.5) : Color.white.opacity(0.5))
                    Text("$0.0")
                        .font(Font.mainFont(size: 15))
                        .foregroundColor(type == .asset ? Color.lightActiveLabel.opacity(0.8) : Color.white.opacity(0.8))

                }
                .padding()
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#if DEBUG
struct MarketValueView_Previews: PreviewProvider {
    static var previews: some View {
        MarketValueView(
            timeframe: .constant(.hour),
            totalValue: .constant("$2836.21"),
            change: .constant("-$423 (3.46%)"),
            chartDataEntries: .constant([
                ChartDataEntry(x: 0.0, y: 7176.99),
                ChartDataEntry(x: 1.0, y: 7156.99),
                ChartDataEntry(x: 2.0, y: 7140.92),
                ChartDataEntry(x: 3.0, y: 7170.18),
                ChartDataEntry(x: 4.0, y: 7166.14),
                ChartDataEntry(x: 5.0, y: 7199.79),
                ChartDataEntry(x: 6.0, y: 7199.97),
                ChartDataEntry(x: 7.0, y: 7201.38),
                ChartDataEntry(x: 8.0, y: 7173.5),
                ChartDataEntry(x: 9.0, y: 7202.12),
                ChartDataEntry(x: 10.0, y: 7212.33),
                ChartDataEntry(x: 11.0, y: 7213.47),
                ChartDataEntry(x: 12.0, y: 7224.86),
                ChartDataEntry(x: 13.0, y: 7218.46),
                ChartDataEntry(x: 14.0, y: 7260.58),
                ChartDataEntry(x: 15.0, y: 7212.6),
                ChartDataEntry(x: 16.0, y: 7204.59),
                ChartDataEntry(x: 17.0, y: 7199.39),
                ChartDataEntry(x: 18.0, y: 7209.57),
                ChartDataEntry(x: 19.0, y: 7205.44),
                ChartDataEntry(x: 20.0, y: 7217.03),
                ChartDataEntry(x: 21.0, y: 7229.49),
                ChartDataEntry(x: 22.0, y: 7233.47),
                ChartDataEntry(x: 23.0, y: 7234.02)
            ]),
            valueCurrencyViewSate: .constant(.fiat)
        )
            .previewLayout(PreviewLayout.sizeThatFits)
            .frame(height: 400)
            .background(Color.portalBackground.edgesIgnoringSafeArea(.all))
    }
}
#endif
