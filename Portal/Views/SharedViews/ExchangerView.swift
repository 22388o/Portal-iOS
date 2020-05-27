//
//  ExchangerView.swift
//  Portal
//
//  Created by Farid on 25.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct Background<Content: View>: View {
    private var content: Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
 
    var body: some View {
        Color.clear
            .overlay(content)
            .padding()
    }
}

struct ExchangerView: View {
    @State var amountInCrypto: String = ""
    @State var amountInFiat: String = ""
    
    private let asset: IAsset
    
    init(asset: IAsset = Asset(coin: Coin(code: "ETH", name: "Ethereum"))) {
        self.asset = asset
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("Amount to send")
                .font(Font.mainFont())
                .foregroundColor(Color.white)
            
            VStack(spacing: 4) {
                HStack(spacing: 8) {
                    Image(uiImage: asset.coin.icon)
                        .resizable()
                        .frame(width: 24, height: 24)
                    TextField("", text: $amountInCrypto)
                        .modifier(
                            PlaceholderStyle(
                                showPlaceHolder: amountInCrypto.isEmpty,
                                placeholder: "0.0"
                            )
                        )
                        .frame(height: 20)
                        .font(Font.mainFont(size: 16))
                        .keyboardType(.numberPad)
                    Text(asset.coin.code)
                        .font(Font.mainFont(size: 16))
                        .foregroundColor(Color.lightActiveLabelNew)//.opacity(0.4)
                }.modifier(TextFieldModifier())
                Text("=")
                    .font(Font.mainFont(size: 16))
                    .foregroundColor(Color.white)//.opacity(0.4)
                HStack(spacing: 8) {
                    FiatCurrencyView(
                        size: 24,
                        currencySymbol: .constant("$"),
                        state: .constant(.fiat),
                        currency: .constant(.fiat(USD))
                    )
                        .frame(width: 24, height: 24)
                    TextField("", text: $amountInFiat)
                        .modifier(
                            PlaceholderStyle(
                                showPlaceHolder: amountInCrypto.isEmpty,
                                placeholder: "0.0"
                            )
                        )
                        .frame(height: 20)
                        .font(Font.mainFont(size: 16))
                        .keyboardType(.numberPad)
                    Text("USD")
                        .font(Font.mainFont(size: 16))
                        .foregroundColor(Color.lightActiveLabelNew)
                }.modifier(TextFieldModifier())
            }
        }
    }
}

#if DEBUG
struct ExchangerView_Previews: PreviewProvider {
    static var previews: some View {
        ExchangerView(
            asset: Asset(
                coin: Coin(
                    code: "ETH",
                    name: "Ethereum",
                    icon:  UIImage(imageLiteralResourceName: "iconEth")
                )
            )
        )
        .previewLayout(PreviewLayout.sizeThatFits)
        .padding()
        .background(Color.portalBackground.edgesIgnoringSafeArea(.all))
    }
}
#endif
