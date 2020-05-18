//
//  WalletViewModel.swift
//  Portal
//
//  Created by Farid on 18.05.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import Foundation
import Combine

final class WalletViewModel: ObservableObject {
    private var subscription: AnyCancellable?
    @Published var assets: [IAsset] = []
    
    init(wallet: Published<IWallet?>.Publisher) {
        subscription = wallet
            .unwrap()
            .sink { [weak self] currentWallet in
                self?.assets = currentWallet.assets
            }
    }
}
