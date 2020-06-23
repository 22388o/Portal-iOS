//
//  ReceiveCoinView.swift
//  Portal
//
//  Created by Farid on 11.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct ReceiveCoinView: View {
    let asset: IAsset
    
    init(asset: IAsset = Asset(coin: Coin(code: "ETH", name: "Ethereum"))) {
        self.asset = asset
    }
    
    var body: some View {
        ZStack {
            Color.portalBackground.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                    .frame(height: 8)
                VStack {
                    Image(uiImage: asset.coin.icon)
                        .resizable()
                        .frame(width: 80, height: 80)
                    Text("Receive \(asset.coin.name)")
                        .font(Font.mainFont(size: 23))
                        .foregroundColor(Color.white)
                        .opacity(0.6)
                }
                VStack {
                    Image(uiImage: asset.qrCodeProvider.qrCode(address: btcMockAddress))
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width - 80, height: UIScreen.main.bounds.width - 80)
                        .cornerRadius(10)

                    VStack(alignment: .center, spacing: 10) {
                        Text("Your \(asset.coin.code) address")
                            .font(Font.mainFont(size: 14))
                            .opacity(0.6)
                        
                        Text(btcMockAddress)
                            .scaledToFill()
                            .font(Font.mainFont(size: 16))
                        
                        Spacer()
                    }
                        .foregroundColor(Color.white)
                        .padding()
                }
                .frame(maxHeight: .infinity)
                
                Button("Share") {}
                    .modifier(PButtonEnabledStyle(enabled: .constant(true)))
                    .padding()
            }
            .padding()
        }
    }
}

#if DEBUG
struct ReceiveCoinView_Previews: PreviewProvider {
    static var previews: some View {
        ReceiveCoinView(asset: Asset(coin: Coin(code: "BTC", name: "Bitcoin", icon: UIImage(imageLiteralResourceName: "iconBtc"))))
    }
}
#endif
