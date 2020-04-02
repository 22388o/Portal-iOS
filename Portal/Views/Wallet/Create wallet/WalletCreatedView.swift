//
//  WalletCreatedView.swift
//  Portal
//
//  Created by Farid on 02.04.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct WalletCreatedView: View {
    let model = BTC()
    var body: some View {
        VStack {
            Title(
                iconName: "iconSafe",
                title: "Wallet created!",
                subtitle: "Add assets to your wallet (in at least 1 currency.)"
            )
            Divider()
            Text("When you have assets in at least one cryptocurrency, your wallet will be ready.")
                .font(Font.mainFont(size: 18))
                .foregroundColor(Color.coinViewRouteButtonActive)
                .opacity(0.85)
                .multilineTextAlignment(.center)
            VStack {
                Image(uiImage: model.QRCode())
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width - 130, height: UIScreen.main.bounds.width - 130)

                VStack(alignment: .center, spacing: 10) {
                    Text("Your \(model.symbol) address")
                        .font(Font.mainFont(size: 14))
                        .foregroundColor(Color.lightActiveLabel)
                        .opacity(0.6)
                    Text(btcMockAddress)
                        .scaledToFill()
                        .font(Font.mainFont(size: 16))
                        .foregroundColor(Color.lightActiveLabel)
                }
            }
            .frame(maxHeight: .infinity)
            
            VStack {
                HStack {
                    Text("Balance")
                        .font(Font.mainFont(size: 16))
                        .foregroundColor(Color.coinViewRouteButtonActive)
                        .opacity(0.85)
                    Text("0.0000000 \(model.symbol)")
                        .font(Font.mainFont(size: 16))
                        .foregroundColor(Color.coinViewRouteButtonActive)
                }
                HStack {
                    Text("Pending")
                        .font(Font.mainFont(size: 16))
                        .foregroundColor(Color.coinViewRouteButtonActive)
                        .opacity(0.85)
                    Text("0.0000000 \(model.symbol)")
                        .font(Font.mainFont(size: 16))
                        .foregroundColor(Color.coinViewRouteButtonActive)
                }
            }.padding()
            
            Button("Open wallet"){}.modifier(PButtonStyle())
            
        }.padding()
    }
}

struct WalletCreatedView_Previews: PreviewProvider {
    static var previews: some View {
        WalletCreatedView()
    }
}
