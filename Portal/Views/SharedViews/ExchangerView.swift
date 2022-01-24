//
//  ExchangerView.swift
//  Portal
//
//  Created by Farid on 25.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct ExchangerView: View {
    @ObservedObject private var viewModel: ExchangerViewModel
    
    private let textHeight: CGFloat = 20
    private let textFieldsVerticalStackSpacing: CGFloat = 4
    private let textFieldHorizontalStackSpacing: CGFloat = 8
    private let iconSize: CGFloat = 24
    private let textFieldFont = Font.mainFont(size: 16)
    
    init(viewModel: ExchangerViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("Amount to send")
                .font(Font.mainFont())
                .foregroundColor(Color.white)
            
            VStack(spacing: textFieldsVerticalStackSpacing) {
                HStack(spacing: textFieldHorizontalStackSpacing) {
                    Image(uiImage: viewModel.asset.icon)
                        .resizable()
                        .frame(width: iconSize, height: iconSize)
                    TextField("", text: $viewModel.assetValue)
                        .modifier(
                            PlaceholderStyle(
                                showPlaceHolder: viewModel.assetValue.isEmpty,
                                placeholder: "0.0"
                            )
                        )
                        .frame(height: textHeight)
                        .keyboardType(.numberPad)
                    Text(viewModel.asset.code)
                        .foregroundColor(Color.lightActiveLabelNew)
                }
                    .modifier(TextFieldModifier())
                
                Text("=").foregroundColor(Color.white)
                
                HStack(spacing: textFieldHorizontalStackSpacing) {
                    FiatCurrencyView(
                        size: iconSize,
                        currencySymbol: .constant(viewModel.fiat.symbol ?? ""),
                        state: .constant(.fiat),
                        currency: .constant(.fiat(USD))
                    )
                        .frame(width: iconSize, height: iconSize)
                    
                    TextField("", text: $viewModel.fiatValue)
                        .modifier(
                            PlaceholderStyle(
                                showPlaceHolder: viewModel.fiatValue.isEmpty,
                                placeholder: "0.0"
                            )
                        )
                        .frame(height: textHeight)
                        .keyboardType(.numberPad)
                    
                    Text(viewModel.fiat.code).foregroundColor(Color.lightActiveLabelNew)
                }
                    .modifier(TextFieldModifier())
            }
                .font(textFieldFont)
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
