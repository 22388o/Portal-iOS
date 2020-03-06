//
//  WalletItemView.swift
//  Portal
//
//  Created by Farid on 06.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct WalletItemView: View {
    private let symbol: String
    private let amount: String
    private let name: String
    private let totalValue: String
    private let price: String
    private let change: String
    
    init(viewModel: WalletItemViewModel) {
        name = viewModel.name
        symbol = viewModel.symbol
        amount = viewModel.amount
        totalValue = viewModel.totalValue
        price = viewModel.price
        change = viewModel.change
    }
    
    var body: some View {
        HStack(alignment: .top) {
            Image("first").frame(width: 60, height: 60, alignment: .center)
            VStack(spacing: 6) {
                HStack() {
                    Text(symbol).font(.headline)
                    HStack() { EmptyView() }.frame(minWidth: 0, maxWidth: .infinity)
                    Text(amount).font(.headline)
                }
                HStack() {
                    Text(name).font(.subheadline)
                    HStack() { EmptyView() }.frame(minWidth: 0, maxWidth: .infinity)
                    Text(totalValue).font(.subheadline)
                }
                HStack() {
                    Text(price).font(.subheadline)
                    HStack() { EmptyView() }.frame(minWidth: 0, maxWidth: .infinity)
                    Text(change).font(.subheadline)
                }
            }
        }.padding([.trailing], 4)
    }
}

struct WalletItemView_Previews: PreviewProvider {
    static var previews: some View {
        WalletItemView(viewModel: CoinMock())
    }
}
