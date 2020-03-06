//
//  WalletItemViewModel.swift
//  Portal
//
//  Created by Farid on 06.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import Foundation

protocol WalletItemViewModel {
    var name: String { get }
    var symbol: String { get }
    var amount: String { get }
    var totalValue: String { get }
    var price: String { get }
    var change: String { get }
}

extension WalletItemViewModel {
    var name: String { "Name" }
    var symbol: String { "Symbol" }
    var amount: String { "Amount" }
    var totalValue: String { "Total Value" }
    var price: String { "Price" }
    var change: String { "Change" }
}
