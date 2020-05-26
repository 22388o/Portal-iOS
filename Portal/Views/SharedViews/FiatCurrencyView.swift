//
//  FiatCurrencyView.swift
//  Portal
//
//  Created by Farid on 26.05.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct FiatCurrencyView: View {
    @Binding var currencySymbol: String
    @Binding var state: ValueCurrencySwitchState
    @Binding var currency: Currency

    private let size: CGFloat = 16
    private let selectedBgColor = Color.white.opacity(0.78)
    private let bgColor = Color(red: 66.0/255.0, green: 73.0/255.0, blue: 84.0/255.0)
    private let textColor = Color(red: 21.0/255.0, green: 52.0/255.0, blue: 66.0/255.0)
        
    var body: some View {
        Text(currencySymbol)
            .font(Font.mainFont(size: 12))
            .foregroundColor(textColor)
            .frame(width: size, height: size)
            .background(state == .fiat ? selectedBgColor : bgColor)
            .cornerRadius(size/2)
    }
}

#if DEBUG
struct FiatCurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        FiatCurrencyView(
            currencySymbol: .constant("$"),
            state: .constant(.fiat),
            currency: .constant(.fiat(USD))
        )
        .previewLayout(PreviewLayout.sizeThatFits)
        .padding()
        .background(Color.portalBackground.edgesIgnoringSafeArea(.all))
    }
}
#endif
