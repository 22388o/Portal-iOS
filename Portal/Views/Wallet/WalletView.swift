//
//  WalletView.swift
//  Portal
//
//  Created by Farid on 06.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct WalletView: View {
    let viewModels: [WalletItemViewModel] = [
        BTC(),
        ETH(),
        CoinMock()
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Wallet")
                .bold()
            List(0 ..< viewModels.count) { index in
                WalletItemView(viewModel: self.viewModels[index])
            }
        }
    }
}

struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView()
    }
}
