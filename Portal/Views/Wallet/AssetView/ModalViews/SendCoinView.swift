//
//  SendCoinView.swift
//  Portal
//
//  Created by Farid on 11.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct SendCoinView: View {
    private let asset: IAsset
    @State var sendToAddress: String = ""
    
    init(asset: IAsset = Asset(coin: Coin(code: "ETH", name: "Ethereum"))) {
        self.asset = asset
    }
    
    private func endEditing() {
        UIApplication.shared.windows.first?.endEditing(true)
    }
    
    var body: some View {
        ZStack {
            Color.portalBackground.edgesIgnoringSafeArea(.all)
            
            Background {
                VStack {
                    Spacer()
                        .frame(height: 8)
                    VStack {
                        Image(uiImage: self.asset.coin.icon)
                            .resizable()
                            .frame(width: 80, height: 80)
                        Text("Send \(self.asset.coin.name)")
                            .font(Font.mainFont(size: 23))
                            .foregroundColor(Color.white)
                        Text("Instantly send to any \(self.asset.coin.code) address")
                            .font(Font.mainFont())
                            .foregroundColor(Color.white)
                            .opacity(0.6)
                    }
                    
                    Spacer().frame(height: 8)
                    
                    HStack {
                        Text("You have")
                            .font(Font.mainFont())
                            .foregroundColor(Color.white)
                            .opacity(0.6)
                        
                        Text("\(self.asset.balanceProvider.balanceString) \(self.asset.coin.code)")
                            .font(Font.mainFont(size: 14))
                            .foregroundColor(Color.white)
                        
                        Button("send all") {
                            
                        }
                            .padding([.trailing, .leading], 8)
                            .padding([.top, .bottom], 4)
                            .background(Color.assetViewButton)
                            .cornerRadius(12)
                            .font(Font.mainFont(size: 12))
                            .foregroundColor(.white)
                    }
                    
                    Spacer().frame(height: 16)
                    
                    ExchangerView(asset: self.asset)
                    
                    Spacer().frame(height: 16)
                    
                    VStack(alignment: .leading) {
                        Text("Send to...")
                            .font(Font.mainFont())
                            .foregroundColor(Color.white)
                        
                        Spacer().frame(height: 16)
                        
                        VStack {
                            TextField("", text: self.$sendToAddress)
                                .modifier(
                                    PlaceholderStyle(
                                        showPlaceHolder: self.sendToAddress.isEmpty,
                                        placeholder: "Enter \(self.asset.coin.code) address..."
                                    )
                                )
                                .frame(height: 20)
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
}

#if DEBUG
struct SendCoinsView_Previews: PreviewProvider {
    static var previews: some View {
        SendCoinView(
            asset: Asset(
                coin: Coin(
                    code: "ETH",
                    name: "Ethereum",
                    color: UIColor.yellow,
                    icon: UIImage(imageLiteralResourceName: "iconEth")
                )
            )
        )
    }
}
#endif
 
