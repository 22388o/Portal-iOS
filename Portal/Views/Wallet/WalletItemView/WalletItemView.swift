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
    private let icon: UIImage
    
    init(asset: IAsset) {
        name = asset.coin.name
        symbol = asset.coin.code
        amount = asset.balanceProvider.balanceString
        totalValue = asset.balanceProvider.totalValueString
        price = asset.balanceProvider.price//asset.marketData.priceString(currency: .usd)
        change = asset.marketChangeProvider.changeString
        icon = asset.coin.icon
    }
    
    var body: some View {
        HStack(alignment: .center) {
            Image(uiImage: icon)
                .resizable()
                .frame(width: 24, height: 24)
                .padding([.leading])
            
            VStack(spacing: 6) {
                HStack() {
                    Text(symbol)
                        .font(Font.mainFont(size: 18))
                        .foregroundColor(Color.white)
                    HStack() { EmptyView() }.frame(minWidth: 0, maxWidth: .infinity)
                    Text(amount)
                        .font(Font.mainFont(size: 18))
                        .foregroundColor(Color.white)
                }
                
                HStack() {
                    Text(name)
                        .font(Font.mainFont(size: 14))
                        .foregroundColor(Color.white.opacity(0.6))
                    HStack() { EmptyView() }.frame(minWidth: 0, maxWidth: .infinity)
                    Text(totalValue)
                        .font(Font.mainFont(size: 14))
                        .foregroundColor(Color.white.opacity(0.6))
                }
                
                HStack() {
                    Text(price)
                        .font(Font.mainFont(size: 14))
                        .foregroundColor(Color.white.opacity(0.6))
                    HStack() { EmptyView() }.frame(minWidth: 0, maxWidth: .infinity)
                    Text(change)
                        .font(Font.mainFont(size: 14))
                        .foregroundColor(Color.white.opacity(0.6))
                }
            }
            .padding([.trailing, .top, .bottom], 15)
            .padding(.leading, 5)
        }
        .background(Color.black.opacity(0.25))
        .cornerRadius(16)
    }
}

#if DEBUG
struct WalletItemView_Previews: PreviewProvider {
    static var previews: some View {
        WalletItemView(asset: Asset(coin: Coin(code: "ETH", name: "Ethereum", color: UIColor.yellow, icon: UIImage(imageLiteralResourceName: "iconEth"))))
    }
}
#endif
