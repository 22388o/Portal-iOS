//
//  AssetMarketValueView.swift
//  Portal
//
//  Created by Farid on 10.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

enum AssetMarketValueViewType {
    case portfolio, asset
}

struct AssetMarketValueView: View {
    @State var timeframe: Timeframe = .hour
    
    private let type: AssetMarketValueViewType
    private let viewModel: PortfolioViewModel
    
    init(type: AssetMarketValueViewType = .asset, viewModel: PortfolioViewModel = PortfolioViewModel()) {
        self.viewModel = viewModel
        self.type = type
    }

    var body: some View {
        VStack {
            HStack() {
                Button(action: {
                    self.timeframe = .hour
                }) {
                    Text("Hour").modifier(TimeframeButton(type: type, isSelected: timeframe == .hour))
                }

                Button(action: {
                    self.timeframe = .day
                }) {
                    Text("Day").modifier(TimeframeButton(type: type, isSelected: timeframe == .day))
                }

                Button(action: {
                    self.timeframe = .week
                }) {
                    Text("Week").modifier(TimeframeButton(type: type, isSelected: timeframe == .week))
                }
                Button(action: {
                    self.timeframe = .month
                }) {
                    Text("Month").modifier(TimeframeButton(type: type, isSelected: timeframe == .month))
                }
                                
                Button(action: {
                    self.timeframe = .year
                }) {
                    Text("Year").modifier(TimeframeButton(type: type, isSelected: timeframe == .year))
                }

                Button(action: {
                    self.timeframe = .allTime
                }) {
                    Text("All time").modifier(TimeframeButton(type: type, isSelected: timeframe == .allTime))
                }
            }
            .padding()
            
            VStack {
                Text(type == .asset ? "Current value" : "Total value")
                    .font(.custom("Avenir-Medium", size: 12))
                    .foregroundColor(type == .asset ? Color.lightInactiveLabel : Color.white.opacity(0.5))
                Text(viewModel.totalValue).font(.largeTitle)
                    .font(.custom("Avenir-Medium", size: 28))
                    .foregroundColor(type == .asset ? Color.assetValueLabel : Color.white.opacity(0.8))
                Text("-$423 (3.46%)")
                    .font(.custom("Avenir-Medium", size: 15))
                    .foregroundColor(Color(red: 228.0/255.0, green: 136.0/255.0, blue: 37.0/255.0))
            }
            .padding()
            
            LineChartUIKitWrapper()
                .frame(height: 150)
                .padding()
            
            HStack(spacing: 80) {
                VStack(spacing: 10) {
                    Text("High")
                        .font(.custom("Avenir-Medium", size: 12))
                        .foregroundColor(type == .asset ? Color.lightActiveLabel.opacity(0.5) : Color.white.opacity(0.5))
                    Text("$0.0")
                        .font(.custom("Avenir-Medium", size: 15))
                        .foregroundColor(type == .asset ? Color.lightActiveLabel.opacity(0.8) : Color.white.opacity(0.8))
                }
                .padding()
                
                VStack(spacing: 10) {
                    Text("Low")
                        .font(.custom("Avenir-Medium", size: 12))
                        .foregroundColor(type == .asset ? Color.lightActiveLabel.opacity(0.5) : Color.white.opacity(0.5))
                    Text("$0.0")
                        .font(.custom("Avenir-Medium", size: 15))
                        .foregroundColor(type == .asset ? Color.lightActiveLabel.opacity(0.8) : Color.white.opacity(0.8))

                }
                .padding()
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}

struct TimeframeButton: ViewModifier {
    var type: AssetMarketValueViewType
    var isSelected: Bool
    
    func body(content: Content) -> some View {
        content
            .font(.custom("Avenir-Medium", size: 12))
            .foregroundColor(foregroundColor(for: type, isSelected: isSelected))
            .frame(maxWidth: .infinity)
    }
    
    private func foregroundColor(for type: AssetMarketValueViewType, isSelected: Bool) -> Color {
        switch type {
        case .asset:
            return isSelected ? Color.lightActiveLabel : Color.lightInactiveLabel
        case .portfolio:
            return isSelected ? Color.white : Color.darkInactiveLabel
        }
    }
}

#if DEBUG
struct AssetMarketValueView_Previews: PreviewProvider {
    static var previews: some View {
        AssetMarketValueView(type: .asset)
    }
}
#endif
