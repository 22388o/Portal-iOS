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
    
    init(asset: IAsset = BTC()) {
        self.asset = asset
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("Amount to send")
                .font(Font.mainFont())
                .foregroundColor(Color.lightActiveLabel)
                .opacity(0.6)
            
            VStack(spacing: 4) {
                HStack(spacing: 8) {
                    Image(uiImage: asset.viewModel.icon)
                        .resizable()
                        .frame(width: 24, height: 24)
                    TextField("0.0", text: $amountInCrypto)
                        .textFieldStyle(PlainTextFieldStyle())
                        .font(Font.mainFont(size: 16))
                        .keyboardType(.numberPad)
                    Text(asset.viewModel.symbol)
                        .font(Font.mainFont(size: 16))
                        .foregroundColor(Color.lightActiveLabel).opacity(0.4)
                }.modifier(TextFieldModifier())
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
                }.modifier(TextFieldModifier())
            }
        }
    }
}

#if DEBUG
struct ExchangerView_Previews: PreviewProvider {
    static var previews: some View {
        ExchangerView(asset: ETH()).padding()
    }
}
#endif
