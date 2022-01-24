//
//  AssetView.swift
//  Portal
//
//  Created by Farid on 06.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI
//import Charts

enum CoinViewRoute {
    case value, transactions, alerts
}

struct AssetView: View {
    private let dividerOffset: CGFloat = 50
    private let minimumHeight: CGFloat = 700
    private let topOffset: CGFloat = 25
    private let sideOffset: CGFloat = 20
    
    @Environment(\.verticalSizeClass) private var verticalSizeClass: UserInterfaceSizeClass?
    @ObservedObject private var viewModel: AssetViewModel
    
    init(asset: IAsset) {
        viewModel = .init(asset: asset)
    }
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    private func body(for size: CGSize) -> some View {
        ZStack {
            Color.portalBackground.edgesIgnoringSafeArea(.all)
            
            VStack {
                AssetTitleView(viewModel: viewModel, smallSize: isSmallView(size: size))
                    .padding([.leading, .trailing], sideOffset)
                
                Spacer()
                
                AssetViewRouteControls(route: $viewModel.route)
                
                Divider()
                    .frame(width: size.width - dividerOffset)
                
                self.containedView()
                    .frame(maxHeight: .infinity)
            }
            .padding(.top, isSmallView(size: size) ? 0 : topOffset)
        }
    }
    
    private func containedView() -> AnyView {
        switch viewModel.route {
        case .value:
            return AnyView(
                MarketValueView(
                    timeframe: $viewModel.selectedTimeframe,
                    totalValue: $viewModel.totalValue,
                    change: $viewModel.change,
                    chartDataEntries: $viewModel.chartDataEntries,
                    valueCurrencyViewSate: $viewModel.valueCurrencySwitchState
                )
            )
        case .transactions:
            return AnyView(TransactionsListView(coin: viewModel.asset.coin))
        case .alerts:
            return AnyView(AlertsListView())
        }
    }
    
    private func isSmallView(size: CGSize) -> Bool {
        size.height < minimumHeight
    }
}

#if DEBUG
struct AssetView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AssetView(
                asset: Asset(
                    coin: Coin(
                        code: "BTC",
                        name: "Bitcoin",
                        icon: UIImage(imageLiteralResourceName: "iconBtc")
                    )
                )
            )
            .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
            .previewDisplayName("iPhone SE")
            
            AssetView(
                asset: Asset(
                    coin: Coin(
                        code: "BTC",
                        name: "Bitcoin",
                        icon: UIImage(imageLiteralResourceName: "iconBtc")
                    )
                )
            )
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
            .previewDisplayName("iPhone 11 Pro")
            
            AssetView(
                asset: Asset(
                    coin: Coin(
                        code: "BTC",
                        name: "Bitcoin",
                        icon: UIImage(imageLiteralResourceName: "iconBtc")
                    )
                )
            )
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
            .previewDisplayName("iPhone 11 Pro Max")
        }
    }
}
#endif
