//
//  WalletCreatedView.swift
//  Portal
//
//  Created by Farid on 02.04.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct WalletCreatedView: View {
    @EnvironmentObject private var walletCoordinator: WalletCoordinator
    @State private var showWallet = false

    let asset = Asset(coin: Coin(code: "ETH", name: "Ethereum"))
    var body: some View {
        VStack {
            NavigationLink(
                destination: MainView(),
                isActive: self.$showWallet) {
              EmptyView()
            }
                .hidden()
            
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
            VStack(spacing: 8) {
                Text("Bitcoin")
                    .font(Font.mainFont(size: 32))
                    .foregroundColor(Color.coinViewRouteButtonActive)
                Image(uiImage: asset.qrCodeProvider.qrCode(address: btcMockAddress))
                    .resizable()
                    .frame(width: 200.0, height: 200.0, alignment: .center)

                VStack(alignment: .center, spacing: 10) {
                    Text("Your \(asset.coin.code) address")
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
                        .opacity(0.85)
                    Text("0.0000000 \(asset.coin.code)")
                }
                    .font(Font.mainFont(size: 16))
                    .foregroundColor(Color.coinViewRouteButtonActive)
                HStack {
                    Text("Pending")
                        .opacity(0.85)
                    Text("0.0000000 \(asset.coin.code)")
                }
                    .font(Font.mainFont(size: 16))
                    .foregroundColor(Color.coinViewRouteButtonActive)
                HStack {
                    Text("Syncing")
                        .opacity(0.85)
                    Text("0.63%")
                }
                    .font(Font.mainFont(size: 16))
                    .foregroundColor(Color.coinViewRouteButtonActive)
                
            }
                .padding()
            
                Button("Open wallet") {
                    self.showWallet.toggle()
                }
                    .modifier(PButtonEnabledStyle(enabled: .constant(true)))
            }
                .padding().hideNavigationBar()
    }
}

struct WalletCreatedView_Previews: PreviewProvider {
    static var previews: some View {
        WalletCreatedView()
    }
}
