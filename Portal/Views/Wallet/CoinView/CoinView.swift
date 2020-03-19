//
//  CoinDetailsView.swift
//  Portal
//
//  Created by Farid on 06.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

enum CoinViewRoute {
    case value, transactions, alerts
}

struct CoinView: View {
    @Binding var model: WalletItemViewModel
    
    @State var showSendView = false
    @State var showReceiveView = false
    @State var showSendToExchangeView = false
    @State var showWithdrawView = false
    
    @State var route: CoinViewRoute = .value
    
    var body: some View {
        VStack() {
            VStack(alignment: .leading, spacing: 10) {
                VStack(alignment: .leading, spacing: 0.0) {
                    HStack {
                        Image(uiImage: model.icon)
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text("\(model.name)")
                            .font(.custom("Avenir-Medium", size: 15))
                            .foregroundColor(Color.lightActiveLabel)
                    }
                    
                    Text("\(model.amount)")
                        .font(.custom("Avenir-Medium", size: 28))
                        .foregroundColor(Color.assetValueLabel)
                }
                .frame(height: 75)
                                
                VStack(spacing: 8) {
                    HStack() {
                        Spacer()
                        Button("Send") { self.showSendView.toggle() }
                            .modifier(PButtonStyle())
                            .sheet(isPresented: self.$showSendView) {
                                SendCoinView()
                            }
                        Spacer()
                        Button("Receive") { self.showReceiveView.toggle() }
                            .modifier(PButtonStyle())
                            .sheet(isPresented: self.$showReceiveView) {
                                ReceiveCoinView(viewModel: self.model)
                            }
                        Spacer()
                    }
                    
                    HStack() {
                        Spacer()
                        Button("Send to exchange") { self.showSendToExchangeView.toggle() }
                            .modifier(PButtonStyle())
                            .sheet(isPresented: self.$showSendToExchangeView) {
                                SendToExchangeView()
                            }
                        Spacer()
                    }
                    
                    HStack() {
                        Spacer()
                        Button("Withdraw") { self.showWithdrawView.toggle() }
                            .modifier(PButtonStyle())
                            .sheet(isPresented: self.$showWithdrawView) {
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
                Button(action: { self.route = .value }) {
                    Text("Value")
                        .font(.custom("Avenir-Medium", size: 15))
                        .foregroundColor(route == .value ? Color.coinViewRouteButtonActive : Color.coinViewRouteButtonInactive)
                }
                .frame(width: 110)
                
                Button(action: { self.route = .transactions }) {
                    Text("Transactions")
                        .font(.custom("Avenir-Medium", size: 15))
                        .foregroundColor(route == .transactions ? Color.coinViewRouteButtonActive : Color.coinViewRouteButtonInactive)
                }
                .frame(width: 110)
                
                Button(action: { self.route = .alerts }) {
                    Text("Alerts")
                        .font(.custom("Avenir-Medium", size: 15))
                        .foregroundColor(route == .alerts ? Color.coinViewRouteButtonActive : Color.coinViewRouteButtonInactive)
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
    
    private func containedView() -> AnyView {
        switch self.route {
        case .value:
            return AnyView(AssetMarketValueView(type: .asset))
        case .transactions:
            return AnyView(TransactionsListView(model: $model))
        case .alerts:
            return AnyView(AlertsListView())
        }
    }
    
}

struct PButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(8)
            .background(Color.assetViewButton)
            .cornerRadius(18)
            .font(.custom("Avenir-Medium", size: 16))
            .foregroundColor(.white)
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(Color.assetViewButton, lineWidth: 1)
            )
    }
}

//extension View {
//    func pButtonStyle() -> some View {
//        ModifiedContent(content: self, modifier: PButtonStyle())
//    }
//}

#if DEBUG
struct CoinDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CoinView(model: .constant(BTC()))
    }
}
#endif
