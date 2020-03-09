//
//  WalletItemViewModel.swift
//  Portal
//
//  Created by Farid on 06.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import Foundation
import SwiftUI

protocol WalletItemViewModel {
    var name: String { get }
    var symbol: String { get }
    var amount: String { get }
    var totalValue: String { get }
    var price: String { get }
    var change: String { get }
    var color: UIColor { get }
    
    func value(currency: Currency) -> Double
}

extension WalletItemViewModel {
    var name: String { "Name" }
    var symbol: String { "Symbol" }
    var amount: String { "Amount" }
    var totalValue: String { "Total Value" }
    var price: String { "Price" }
    var change: String { "Change" }
    var color: UIColor { UIColor.clear }
    func value(currency: Currency) -> Double {
        Double(totalValue) ?? 0.0
        //balance * marketData.price(currency: currency)
    }
}
