//
//  ContentView.swift
//  Portal
//
//  Created by Farid on 06.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @State private var selection = 0
 
    var body: some View {
        TabView(selection: $selection){
            WalletView()
                .font(.title)
                .tabItem {
                    VStack {
                        Image("first")
                        Text("Wallet")
                    }
                }
                .tag(0)
            AtomicBridgeView()
                .font(.title)
                .tabItem {
                    VStack {
                        Image("second")
                        Text("Atomic Bridge")
                    }
                }
                .tag(1)
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
#endif
