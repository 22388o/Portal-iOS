//
//  CreateWalletViewModel.swift
//  Portal
//
//  Created by Farid on 14.05.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import Foundation
import Combine

final class CreateWalletViewModel: ObservableObject {
    @Published var name = String()
    @Published var walletDataValidated = false
    @Published var selectorIndex = BtcAddressFormat.segwit.rawValue
    
    private var subscription: AnyCancellable?
        
    func setup() {
        subscription = $name
//        .debounce(for: .seconds(0.25), scheduler: DispatchQueue.main)
        .sink { [weak self] name in
            self?.walletDataValidated = name.count > 3
        }
    }
    
    func newModel() -> NewWalletModel {
        .init(
            name: name,
            addressType: BtcAddressFormat.init(rawValue: selectorIndex) ?? .segwit
        )
    }
    
    deinit {
        subscription?.cancel()
        subscription = nil
    }
}
