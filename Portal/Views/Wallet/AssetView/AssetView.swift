//
//  AssetView.swift
//  Portal
//
//  Created by Farid on 06.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI
import Charts

enum CoinViewRoute {
    case value, transactions, alerts
}

struct AssetView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @ObservedObject var viewModel: AssetViewModel
    
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
                VStack(alignment: .leading, spacing: 10) {
                    if size.height < 700 {
                        HStack {
                            HStack {
                                Image(uiImage: viewModel.icon)
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                Text("\(viewModel.name)")
                                    .font(Font.mainFont(size: 15))
                                    .foregroundColor(Color.lightActiveLabel)
                            }
                            
                            Spacer()
                            
                            Text("\(viewModel.balance)")
                                .font(Font.mainFont(size: 28))
                                .foregroundColor(Color.coinViewRouteButtonInactive)
                        }
                        .frame(height: 35)
                    } else {
                        VStack(alignment: .leading, spacing: 0.0) {
                            HStack {
                                Image(uiImage: viewModel.icon)
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                Text("\(viewModel.name)")
                                    .font(Font.mainFont(size: 15))
                                    .foregroundColor(Color.lightActiveLabel)
                            }
                            
                            Text("\(viewModel.balance)")
                                .font(Font.mainFont(size: 28))
                                .foregroundColor(Color.coinViewRouteButtonInactive)
                        }
                        .frame(height: 75)
                    }
                                    
                    VStack(spacing: 8) {
                        HStack {
                            Spacer()
                            Button("Send") {
                                self.viewModel.showSendView.toggle()
                            }
                            .modifier(PButtonEnabledStyle(enabled: .constant(true)))
                            .sheet(isPresented: $viewModel.showSendView) {
                                SendCoinView(asset: self.viewModel.asset)
                            }
                            Spacer()
                            Button("Receive") {
                                self.viewModel.showReceiveView.toggle()
                            }
                            .modifier(PButtonEnabledStyle(enabled: .constant(true)))
                            .sheet(isPresented: $viewModel.showReceiveView) {
                                ReceiveCoinView(asset: self.viewModel.asset)
                            }
                            Spacer()
                        }
                        
                        HStack {
                            Spacer()
                            Button("Send to exchange") {
                                self.viewModel.showSendToExchangeView.toggle()
                            }
                            .modifier(PButtonEnabledStyle(enabled: .constant(true)))
                            .sheet(isPresented: $viewModel.showSendToExchangeView) {
                                SendToExchangeView(asset: self.viewModel.asset)
                            }
                            Spacer()
                        }
                        
                        HStack {
                            Spacer()
                            Button("Withdraw") {
                                self.viewModel.showWithdrawView.toggle()
                            }
                            .modifier(PButtonEnabledStyle(enabled: .constant(true)))
                            .sheet(isPresented: $viewModel.showWithdrawView) {
                                WithdrawCoinView()
                            }
                            Spacer()
                        }

                    }
                    .padding([.leading, .trailing], -10)
                    
                }
                .padding([.leading, .trailing], 20)
                
                Spacer()
                            
                HStack(alignment: .center) {
                    Group {
                        Button(action: { self.viewModel.route = .value }) {
                            Text("Value")
                                .foregroundColor(viewModel.route == .value ? Color.coinViewRouteButtonInactive : Color.coinViewRouteButtonActive)
                        }
                        
                        Button(action: { self.viewModel.route = .transactions }) {
                            Text("Transactions")
                                .foregroundColor(viewModel.route == .transactions ?  Color.coinViewRouteButtonInactive : Color.coinViewRouteButtonActive)
                        }
                        
                        Button(action: { self.viewModel.route = .alerts }) {
                            Text("Alerts")
                                .foregroundColor(viewModel.route == .alerts ? Color.coinViewRouteButtonInactive : Color.coinViewRouteButtonActive)
                        }
                    }
                        .frame(width: 110)
                }
                    .font(Font.mainFont(size: 15))
                    .padding(.top, 12)
                
                Divider()
                    .frame(width: UIScreen.main.bounds.width - 50)
                            
                self.containedView()
                    .frame(maxHeight: .infinity)
            }
            .padding(.top, size.height < 700 ? 0 : 25)
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
