//
//  SendToExchangeView.swift
//  Portal
//
//  Created by Farid on 11.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct SendToExchangeView: View {
    private let asset: IAsset
    @State var sendToAddress: String = ""
    
    init(asset: IAsset = BTC()) {
        self.asset = asset
    }
    
    private func endEditing() {
        UIApplication.shared.windows.first?.endEditing(true)
    }
    
    var body: some View {
        Background {
            VStack {
                Spacer()
                    .frame(height: 8)
                VStack {
                    Image(uiImage: self.asset.viewModel.icon)
                        .resizable()
                        .frame(width: 80, height: 80)
                    Text("Send \(self.asset.viewModel.name) to exchange")
                        .font(Font.mainFont(size: 23))
                        .foregroundColor(Color.lightActiveLabel)
                    Text("Transfer \(self.asset.viewModel.symbol) into exchange balance to trade with.")
                        .font(Font.mainFont())
                        .foregroundColor(Color.lightActiveLabel)
                        .opacity(0.6)
                }
                
                Spacer().frame(height: 16)
                
                VStack(spacing: 6) {
                    Divider()
                    HStack {
                        Text("Avaliable in wallet")
                            .font(Font.mainFont())
                            .foregroundColor(Color.lightActiveLabel)
                            .opacity(0.6)
                        
                        Text("\(self.asset.viewModel.amount) \(self.asset.viewModel.symbol)")
                            .font(Font.mainFont(size: 14))
                            .foregroundColor(Color.lightActiveLabel)
                        
                        Button("send all") {
                            
                        }
                            .padding([.trailing, .leading], 8)
                            .padding([.top, .bottom], 4)
                            .background(Color.assetViewButton)
                            .cornerRadius(12)
                            .font(Font.mainFont(size: 12))
                            .foregroundColor(.white)
                    }
                    Divider()
                    HStack {
                        Text("Currently in exchange")
                            .font(Font.mainFont())
                            .foregroundColor(Color.lightActiveLabel)
                            .opacity(0.6)
                        
                        Text("0.0 \(self.asset.viewModel.symbol) ($0.0)")
                            .font(Font.mainFont(size: 14))
                            .foregroundColor(Color.lightActiveLabel)
                        
                    }
                    Divider()
                }
                
                Spacer().frame(height: 24)
                
                ExchangerView(asset: self.asset)
                
                Spacer().frame(height: 16)
                
                VStack(alignment: .leading) {
                    Text("Send to...")
                        .font(Font.mainFont())
                        .foregroundColor(Color.lightActiveLabel)
                        .opacity(0.6)
                    
                    Spacer().frame(height: 16)
                    
                    VStack {
                        TextField("Enter \(self.asset.viewModel.symbol) address...", text: self.$sendToAddress)
                        .textFieldStyle(PlainTextFieldStyle())
                        .font(Font.mainFont(size: 16))
                    }.modifier(TextFieldModifier())
                }

                Spacer()
                
                Button("Send") {
                    
                }
                .modifier(PButtonEnabledStyle(enabled: .constant(true)))
            }
        }.onTapGesture {
            self.endEditing()
        }
    }
}

#if DEBUG
struct SendToExchangeView_Previews: PreviewProvider {
    static var previews: some View {
        SendToExchangeView(asset: BTC())
    }
}
#endif
