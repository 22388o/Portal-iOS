//
//  ContentView.swift
//  Portal
//
//  Created by Farid on 06.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct TabbedBarView: View {
    @State private var selection = 0
    @State private var hasWallet = false
    
    init() {
        UITabBar.appearance().barTintColor = UIColor(white: 0, alpha: 0.1)
    }
 
    var body: some View {
        ZStack {
            Color.portalBackground.edgesIgnoringSafeArea(.all)
            TabView(selection: $selection) {
                WalletView()
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
        }.hideNavigationBar()
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabbedBarView()
    }
}
#endif
