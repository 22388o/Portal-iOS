//
//  CoinDetailsView.swift
//  Portal
//
//  Created by Farid on 06.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct CoinView: View {
    @Binding var showModal: Bool
    @Binding var model: WalletItemViewModel
    
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
                        
                        Button(action: {
                            
                        }) {
                            Text("Send")
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding(8)
                        .background(Color.purple)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.purple, lineWidth: 1)
                        )
                        
                        Spacer()
                        
                        Button(action: {
                            
                        }) {
                            Text("Receive")
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding(8)
                        .background(Color.purple)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.purple, lineWidth: 1)
                        )
                        
                        Spacer()
                    }
                    
                    HStack() {
                        Spacer()
                        
                        Button(action: {
                            
                        }) {
                            Text("Send to exchange")
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding(8)
                        .background(Color.purple)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.purple, lineWidth: 1)
                        )
                        
                        Spacer()
                    }
                    
                    HStack() {
                        Spacer()
                        
                        Button(action: {
                            
                        }) {
                            Text("Withdraw")
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding(8)
                        .background(Color.purple)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.purple, lineWidth: 1)
                        )
                        
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

struct CoinDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CoinView(showModal: .constant(true), model: .constant(CoinMock()))
    }
}
