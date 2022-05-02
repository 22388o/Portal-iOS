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
    @State private var sendToAddress = String()
    
    init(asset: IAsset = Asset(coin: Coin.ethereum())) {
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
                    Image(uiImage: UIImage(imageLiteralResourceName: "iconBtc"))
                        .resizable()
                        .frame(width: 80, height: 80)
                    Text("Send \(self.asset.coin.name) to exchange")
                        .font(Font.mainFont(size: 23))
                    Text("Transfer \(self.asset.coin.code) into exchange balance to trade with.")
                        .font(Font.mainFont())
                        .opacity(0.6)
                }
                    .foregroundColor(Color.lightActiveLabel)
                
                Spacer().frame(height: 16)
                
                VStack(spacing: 6) {
                    Divider()
                    HStack {
                        Text("Avaliable in wallet")
                            .font(Font.mainFont())
                            .opacity(0.6)
                        
                        Text("\(self.asset.balanceProvider.balanceString) \(self.asset.coin.code)")
                            .font(Font.mainFont(size: 14))
                        
                        Button("send all") {
                            
                        }
                            .padding([.trailing, .leading], 8)
                            .padding([.top, .bottom], 4)
                            .background(Color.assetViewButton)
                            .cornerRadius(12)
                            .font(Font.mainFont(size: 12))
                            .foregroundColor(.white)
                    }
                        .foregroundColor(Color.lightActiveLabel)

                    Divider()
                    HStack {
                        Text("Currently in exchange")
                            .font(Font.mainFont())
                            .opacity(0.6)
                        
                        Text("0.0 \(self.asset.coin.code) ($0.0)")
                            .font(Font.mainFont(size: 14))
                        
                    }
                        .foregroundColor(Color.lightActiveLabel)
                    
                    Divider()
                }
                
                Spacer().frame(height: 24)
                
                ExchangerView(viewModel: .init(asset: self.asset.coin, fiat: USD))
                
                Spacer().frame(height: 16)
                
                VStack(alignment: .leading) {
                    Text("Send to...")
                        .font(Font.mainFont())
                        .foregroundColor(Color.lightActiveLabel)
                        .opacity(0.6)
                    
                    Spacer().frame(height: 16)
                    
                    VStack {
                        TextField("Enter \(self.asset.coin.code) address...", text: self.$sendToAddress)
                        .textFieldStyle(PlainTextFieldStyle())
                        .font(Font.mainFont(size: 16))
                    }
                        .modifier(TextFieldModifier())
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
        SendToExchangeView(asset: Asset(coin: Coin.ethereum()))
    }
}
#endif
