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
    
    private let model: WalletItemViewModel
    
    init(viewModel: WalletItemViewModel = CoinMock()) {
        self.model = viewModel
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("Amount to send")
                .font(Font.mainFont())
                .foregroundColor(Color.lightActiveLabel)
                .opacity(0.6)
            
            VStack(spacing: 4) {
                HStack(spacing: 8) {
                    Image(uiImage: model.icon)
                        .resizable()
                        .frame(width: 24, height: 24)
                    TextField("0.0", text: $amountInCrypto)
                        .textFieldStyle(PlainTextFieldStyle())
                        .font(Font.mainFont(size: 16))
                        .keyboardType(.numberPad)
                    Text(model.symbol)
                        .font(Font.mainFont(size: 16))
                        .foregroundColor(Color.lightActiveLabel).opacity(0.4)
                }.modifier(ExchangerTextField())
                Text("=")
                    .font(Font.mainFont(size: 16))
                    .foregroundColor(Color.lightActiveLabel).opacity(0.4)
                HStack(spacing: 8) {
                    Image("usdAssetIcon")
                        .resizable()
                        .frame(width: 24, height: 24)
                    TextField("0.0", text: $amountInFiat)
                        .textFieldStyle(PlainTextFieldStyle())
                        .font(Font.mainFont(size: 16))
                        .keyboardType(.numberPad)
                    Text("USD")
                        .font(Font.mainFont(size: 16))
                        .foregroundColor(Color.lightActiveLabel).opacity(0.4)
                }.modifier(ExchangerTextField())
            }
        }
    }
}

#if DEBUG
struct ExchangerView_Previews: PreviewProvider {
    static var previews: some View {
        ExchangerView(viewModel: ETH()).padding()
    }
}
#endif
