//
//  ContentView.swift
//  Portal
//
//  Created by Farid on 06.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var walletCoordinator: WalletCoordinator
    @State private var selection = 0
 
    var body: some View {
        ZStack {
            Color.portalBackground.edgesIgnoringSafeArea(.all)
            TabView(selection: $selection) {
                WalletView(walletCoordinator: self.walletCoordinator)
                    .tabItem {
                        VStack {
                            Image(systemName: "1.square.fill")
                            Text("Wallet")
                        }
                    }
                    .tag(0)
                    .hideNavigationBar()

                AtomicBridgeView()
                    .tabItem {
                        VStack {
                            Image(systemName: "2.square.fill")
                            Text("Atomic Bridge")
                        }
                    }
                    .tag(1)
                .hideNavigationBar()
            }
        }
        .hideNavigationBar()
//        .onReceive(walletCoordinator.$currentWallet, perform: { newWallet in
//            guard newWallet != nil else { return }
//            self.wallet = newWallet!
//        })
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(
                WalletCoordinator(mockedWallet: WalletMock())
            )
    }
}
#endif
