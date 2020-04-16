//
//  RootView.swift
//  Portal
//
//  Created by Farid on 09.04.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

protocol HistoricalData {
    func fetchHistoricalData()
}

struct RootView: View {
    @State private var hasWallet = true
    
    @ViewBuilder
    var body: some View {
        NavigationView {
            if hasWallet {
                TabbedBarView()
            } else {
                CreateWalletView().hideNavigationBar()
            }
        }
    }
}

#if DEBUG
struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
#endif
