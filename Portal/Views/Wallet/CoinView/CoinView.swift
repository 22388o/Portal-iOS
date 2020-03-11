//
//  CoinDetailsView.swift
//  Portal
//
//  Created by Farid on 06.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct CoinView: View {
    @Binding var model: WalletItemViewModel
    
    @State var showSendView = false
    @State var showReceiveView = false
    @State var showSendToExchangeView = false
    @State var showWithdrawView = false
    
    var body: some View {
        VStack() {
            VStack(alignment: .leading, spacing: 10) {
                VStack(alignment: .leading, spacing: 0.0) {
                    HStack {
                        Image("first")
                        Text("\(model.name)")
                    }
                    
                    Text("\(model.amount)")
                        .font(.title)
                }
                                
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
                                ReceiveCoinView()
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
                .padding(-5)
                
            }
            .padding()
            
            Spacer()
                        
            HStack(alignment: .center, spacing: 60) {
                Button(action: {}) { Text("Value") }
                Button(action: {}) { Text("Transactions") }
                Button(action: {}) { Text("Alerts") }
            }
            
            Divider()
            
            Spacer()
            
            AssetMarketValueView()
        }
        .padding(4)
    }
    
}

struct PButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(8)
            .background(Color.purple)
            .cornerRadius(8)
            .foregroundColor(.white)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.purple, lineWidth: 1)
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
        CoinView(model: .constant(CoinMock()))
    }
}
#endif
