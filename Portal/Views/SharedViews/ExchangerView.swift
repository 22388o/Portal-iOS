//
//  ExchangerView.swift
//  Portal
//
//  Created by Farid on 25.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct ExchangerView: View {
    @ObservedObject var viewModel: ExchangerViewModel
    
    init(viewModel: ExchangerViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("Amount to send")
                .font(Font.mainFont())
                .foregroundColor(Color.white)
            
            VStack(spacing: 4) {
                HStack(spacing: 8) {
                    Image(uiImage: viewModel.asset.icon)
                        .resizable()
                        .frame(width: 24, height: 24)
                    TextField("", text: $viewModel.assetValue)
                        .modifier(
                            PlaceholderStyle(
                                showPlaceHolder: viewModel.assetValue.isEmpty,
                                placeholder: "0.0"
                            )
                        )
                        .frame(height: 20)
                        .font(Font.mainFont(size: 16))
                        .keyboardType(.numberPad)
                    Text(viewModel.asset.code)
                        .font(Font.mainFont(size: 16))
                        .foregroundColor(Color.lightActiveLabelNew)//.opacity(0.4)
                }.modifier(TextFieldModifier())
                Text("=")
                    .font(Font.mainFont(size: 16))
                    .foregroundColor(Color.white)//.opacity(0.4)
                HStack(spacing: 8) {
                    FiatCurrencyView(
                        size: 24,
                        currencySymbol: .constant(viewModel.fiat.symbol ?? ""),
                        state: .constant(.fiat),
                        currency: .constant(.fiat(USD))
                    )
                        .frame(width: 24, height: 24)
                    TextField("", text: $viewModel.fiatValue)
                        .modifier(
                            PlaceholderStyle(
                                showPlaceHolder: viewModel.fiatValue.isEmpty,
                                placeholder: "0.0"
                            )
                        )
                        .frame(height: 20)
                        .font(Font.mainFont(size: 16))
                        .keyboardType(.numberPad)
                    Text(viewModel.fiat.code)
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
            viewModel: .init(asset: Coin(
                code: "ETH",
                name: "Ethereum",
                icon:  UIImage(imageLiteralResourceName: "iconEth")
            )
            , fiat: USD))
        .previewLayout(PreviewLayout.sizeThatFits)
        .padding()
        .background(Color.portalBackground.edgesIgnoringSafeArea(.all))
    }
}
#endif
