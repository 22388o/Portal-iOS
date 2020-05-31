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
    @ObservedObject var viewModel: AssetViewModel
    
    init(asset: IAsset) {
        viewModel = .init(asset: asset)
    }
    
    var body: some View {
        ZStack {
            Color.portalBackground.edgesIgnoringSafeArea(.all)
            
            VStack() {
                VStack(alignment: .leading, spacing: 10) {
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
                                    
                    VStack(spacing: 8) {
                        HStack() {
                            Spacer()
                            Button("Send") {
                                self.viewModel.showSendView.toggle()
                            }
                            .modifier(PButtonEnabledStyle(enabled: .constant(true)))
                            .sheet(isPresented: self.$viewModel.showSendView) {
                                SendCoinView(asset: self.viewModel.asset)
                            }
                            Spacer()
                            Button("Receive") {
                                self.viewModel.showReceiveView.toggle()
                            }
                            .modifier(PButtonEnabledStyle(enabled: .constant(true)))
                            .sheet(isPresented: self.$viewModel.showReceiveView) {
                                ReceiveCoinView(asset: self.viewModel.asset)
                            }
                            Spacer()
                        }
                        
                        HStack() {
                            Spacer()
                            Button("Send to exchange") {
                                self.viewModel.showSendToExchangeView.toggle()
                            }
                            .modifier(PButtonEnabledStyle(enabled: .constant(true)))
                            .sheet(isPresented: self.$viewModel.showSendToExchangeView) {
                                SendToExchangeView(asset: self.viewModel.asset)
                            }
                            Spacer()
                        }
                        
                        HStack() {
                            Spacer()
                            Button("Withdraw") {
                                self.viewModel.showWithdrawView.toggle()
                            }
                            .modifier(PButtonEnabledStyle(enabled: .constant(true)))
                            .sheet(isPresented: self.$viewModel.showWithdrawView) {
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
                    Button(action: { self.viewModel.route = .value }) {
                        Text("Value")
                            .font(Font.mainFont(size: 15))
                            .foregroundColor(viewModel.route == .value ? Color.coinViewRouteButtonInactive : Color.coinViewRouteButtonActive)
                    }
                    .frame(width: 110)
                    
                    Button(action: { self.viewModel.route = .transactions }) {
                        Text("Transactions")
                            .font(Font.mainFont(size: 15))
                            .foregroundColor(viewModel.route == .transactions ?  Color.coinViewRouteButtonInactive : Color.coinViewRouteButtonActive)
                    }
                    .frame(width: 110)
                    
                    Button(action: { self.viewModel.route = .alerts }) {
                        Text("Alerts")
                            .font(Font.mainFont(size: 15))
                            .foregroundColor(viewModel.route == .alerts ? Color.coinViewRouteButtonInactive : Color.coinViewRouteButtonActive)
                    }
                    .frame(width: 110)
                }
                .padding(.top, 12)
                
                Divider()
                    .frame(width: UIScreen.main.bounds.width - 50)
                            
                containedView()
                    .frame(maxHeight: .infinity)
            }
            .padding(.top, 25)
        }
    }
    
    private func containedView() -> AnyView {
        switch self.viewModel.route {
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
