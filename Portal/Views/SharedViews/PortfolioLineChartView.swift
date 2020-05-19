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

struct AssetMarketValueViewModel {
    let totalValueString: String
    let changeSting: String
}

struct PortfolioLineChartView: View {
    @State var timeframe: Timeframe = .hour
    
    private let type: AssetMarketValueViewType
    private let viewModel: PortfolioViewModel
    
    init(type: AssetMarketValueViewType = .asset, viewModel: PortfolioViewModel) {
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
            .padding([.leading, .trailing])
            
            VStack {
                VStack(spacing: 4) {
                    Text(type == .asset ? "Current value" : "Total value")
                        .font(Font.mainFont())
                        .foregroundColor(type == .asset ? Color.lightInactiveLabel : Color.white.opacity(0.5))
                    HStack(spacing: 4) {
                        Image("dollarIconLight").resizable().frame(width: 16, height: 16)
                        Image("btcIcon").resizable().frame(width: 16, height: 16)
                        Image("ethIconLight").resizable().frame(width: 16, height: 16)
                    }
                    HStack {
                        Image(type == .asset ? "arrowLeft" : "arrowLeftLight")
                        Spacer()
                        Text(viewModel.totalValue).font(.largeTitle)
                            .font(Font.mainFont(size: 28))
                            .foregroundColor(type == .asset ? Color.assetValueLabel : Color.white.opacity(0.8))
                        Spacer()
                        Image(type == .asset ? "arrowRight" : "arrowRightLight")
                    }
                    .padding([.leading, .trailing])
                    Text("-$423 (3.46%)")
                        .font(Font.mainFont(size: 15))
                        .foregroundColor(Color(red: 228.0/255.0, green: 136.0/255.0, blue: 37.0/255.0))
                }
            }
            .padding()
            
            LineChartUIKitWrapper(viewModel: viewModel)
                .frame(height: 150)
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
struct PortfolioLineChartView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioLineChartView(
            type: .asset,
            viewModel: PortfolioViewModel(assets: WalletMock().assets, marketData: [String : CoinMarketData]())
        )
    }
}
#endif
