//
//  SendCoinViewModel.swift
//  Portal
//
//  Created by Farid on 28.05.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import Foundation
import Combine

final class SendCoinViewModel: ObservableObject {
    let asset: IAsset
    
    @ObservedObject var exchangerViewModel: ExchangerViewModel
    
    @Published var receiverAddress = String()
    @Published var formIsValid = false
    @Published var selctionIndex = 0
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(asset: IAsset) {
        print("SendCoinViewModel init")

        self.asset = asset
        self.exchangerViewModel = .init(asset: asset.coin, fiat: USD)
        
        self.$receiverAddress
            .combineLatest(exchangerViewModel.$assetValue)
            .compactMap { (address, amount) -> Bool in
                address.count > 8 && Double(amount) ?? 0.0 > 0.0
            }
            .sink { [weak self] in self?.formIsValid = $0 }
            .store(in: &subscriptions)
    }
    
    deinit {
        print("SendCoinViewModel deinit")
    }
    
    func sendAll() {
        exchangerViewModel.assetValue = asset.balanceProvider.balanceString
    }
}

