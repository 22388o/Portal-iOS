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
        ZStack {
            Color.portalBackground.edgesIgnoringSafeArea(.all)
            
            VStack() {
                VStack(alignment: .leading, spacing: 10) {
                    VStack(alignment: .leading, spacing: 0.0) {
                        HStack {
                            Image(uiImage: model.icon)
                                .resizable()
                                .frame(width: 24, height: 24)
                            Text("\(model.name)")
                                .font(Font.mainFont(size: 15))
                                .foregroundColor(Color.lightActiveLabel)
                        }
                        
                        Text("\(model.amount)")
                            .font(Font.mainFont(size: 28))
                            .foregroundColor(Color.coinViewRouteButtonInactive)
                    }
                    .frame(height: 75)
                                    
                    VStack(spacing: 8) {
                        HStack() {
                            Spacer()
                            Button("Send") { self.showSendView.toggle() }
                                .modifier(PButtonStyle())
                                .sheet(isPresented: self.$showSendView) {
                                    SendCoinView(viewModel: self.model)
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
                                    SendToExchangeView(viewModel: self.model)
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
                            .font(Font.mainFont(size: 15))
                            .foregroundColor(route == .value ? Color.coinViewRouteButtonInactive : Color.coinViewRouteButtonActive)
                    }
                    .frame(width: 110)
                    
                    Button(action: { self.route = .transactions }) {
                        Text("Transactions")
                            .font(Font.mainFont(size: 15))
                            .foregroundColor(route == .transactions ?  Color.coinViewRouteButtonInactive : Color.coinViewRouteButtonActive)
                    }
                    .frame(width: 110)
                    
                    Button(action: { self.route = .alerts }) {
                        Text("Alerts")
                            .font(Font.mainFont(size: 15))
                            .foregroundColor(route == .alerts ? Color.coinViewRouteButtonInactive : Color.coinViewRouteButtonActive)
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
        switch self.route {
        case .value:
            return AnyView(AssetMarketValueView(type: .portfolio))
        case .transactions:
            return AnyView(TransactionsListView(model: $model))
        case .alerts:
            return AnyView(AlertsListView())
        }
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
