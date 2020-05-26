//
//  ValueCurrencySwitchView.swift
//  Portal
//
//  Created by Farid on 26.05.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

enum ValueCurrencySwitchState: Int {
    case fiat, btc, eth
}

struct ValueCurrencySwitchView: View {
    @Binding var state: ValueCurrencySwitchState
    @Binding var currencySymbol: String
    
    var body: some View {
        HStack(spacing: 4) {
            FiatCurrencyView(currencySymbol: $currencySymbol, state: $state, currency: .constant(.fiat(USD)))
            Image(state == .btc ? "btcIconLight" : "btcIcon")
                .resizable()
                .frame(width: 16, height: 16)
            Image(state == .eth ? "ethPortfolioIcon" : "ethIconLight")
                .resizable()
                .frame(width: 16, height: 16)
        }
    }
}

#if DEBUG
struct ValueCurrencySwitchView_Previews: PreviewProvider {
    static var previews: some View {
        ValueCurrencySwitchView(
            state: .constant(.fiat),
            currencySymbol: .constant("$")
        )
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .background(Color.portalBackground.edgesIgnoringSafeArea(.all))
    }
}
#endif
