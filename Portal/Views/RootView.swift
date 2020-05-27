//
//  RootView.swift
//  Portal
//
//  Created by Farid on 09.04.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI
import CoreData
import Combine

struct RootView: View {
    @EnvironmentObject var walletCoordinator: WalletCoordinator
    
    init() {
        print("RootView init")
        UITabBar.appearance().barTintColor = UIColor(white: 0, alpha: 0.1)
    }
    
    var body: some View {
        NavigationView {
            if walletCoordinator.currentWallet != nil {
                MainView()
                    .environmentObject(walletCoordinator)
            } else {
                CreateWalletView()
                    .environmentObject(walletCoordinator)
                    .hideNavigationBar()
            }
        }
    }
}

#if DEBUG
struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .environmentObject(
                WalletCoordinator()
            )
    }
}
#endif
