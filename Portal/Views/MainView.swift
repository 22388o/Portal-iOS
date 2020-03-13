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
    
    init() {
        UITabBar.appearance().barTintColor = UIColor(white: 0, alpha: 0.1)
//        UITabBar.appearance().unselectedItemTintColor = UIColor.red
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
                AtomicBridgeView()
//                    .font(.title)
                    .tabItem {
                        VStack {
                            Image(systemName: "2.square.fill")
                            Text("Atomic Bridge")
                        }
                    }
                    .tag(1)
            }
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
