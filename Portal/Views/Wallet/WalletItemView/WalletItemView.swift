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
        HStack(alignment: .center) {
            Image("first")
                .padding([.leading])
            
            VStack(spacing: 6) {
                HStack() {
                    Text(symbol)
                        .font(.custom("Avenir-Medium", size: 18))
                        .foregroundColor(Color.white)
                    HStack() { EmptyView() }.frame(minWidth: 0, maxWidth: .infinity)
                    Text(amount)
                        .font(.custom("Avenir-Medium", size: 18))
                        .foregroundColor(Color.white)
                }
                
                HStack() {
                    Text(name)
                        .font(.custom("Avenir-Medium", size: 14))
                        .foregroundColor(Color.white.opacity(0.6))
                    HStack() { EmptyView() }.frame(minWidth: 0, maxWidth: .infinity)
                    Text(totalValue)
                        .font(.custom("Avenir-Medium", size: 14))
                        .foregroundColor(Color.white.opacity(0.6))
                }
                
                HStack() {
                    Text(price)
                        .font(.custom("Avenir-Medium", size: 14))
                        .foregroundColor(Color.white.opacity(0.6))
                    HStack() { EmptyView() }.frame(minWidth: 0, maxWidth: .infinity)
                    Text(change)
                        .font(.custom("Avenir-Medium", size: 14))
                        .foregroundColor(Color.white.opacity(0.6))
                }
            }
            .padding()
        }
        .background(Color.black.opacity(0.25))
        .cornerRadius(16)
    }
}

#if DEBUG
struct WalletItemView_Previews: PreviewProvider {
    static var previews: some View {
        WalletItemView(viewModel: CoinMock())
    }
}
#endif
