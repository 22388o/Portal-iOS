//
//  MarketValueControlsView.swift
//  Portal
//
//  Created by Farid on 13.07.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct MarketValueControlsView: View {
    @Binding var valueCurrencyViewSate: ValueCurrencySwitchState
    @Binding var change: String
    @Binding var totalValue: String
    @Binding var type: AssetMarketValueViewType
    
    private let changeForegroundColor = Color(red: 228.0/255.0, green: 136.0/255.0, blue: 37.0/255.0)
    
    private let titleFont = Font.mainFont()
    private let totalValueFont = Font.mainFont(size: 28)
    private let changeFont = Font.mainFont(size: 15)
    
    private let verticalSpacing: CGFloat = 4
    
    private var titleForegroundColor: Color {
        type == .asset ? Color.lightInactiveLabel : Color.white.opacity(0.5)
    }
    private var totalValueForegroundColor: Color {
        type == .asset ? Color.assetValueLabel : Color.white.opacity(0.8)
    }
    private var title: String {
        type == .asset ? "Current value" : "Total value"
    }

    var body: some View {
        VStack {
            VStack(spacing: verticalSpacing) {
                Text(title)
                    .font(titleFont)
                    .foregroundColor(titleForegroundColor)
                
                ValueCurrencySwitchView(
                    state: $valueCurrencyViewSate,
                    currencySymbol: .constant("$")
                )
                
                HStack {
                    Button(action: {
                        self.previousCurrency()
                    }) {
                        Image("arrowLeftLight")
                    }
                        .buttonStyle(PlainButtonStyle())
                    
                    Spacer()
                    
                    Text(totalValue).font(.largeTitle)
                        .font(totalValueFont)
                        .foregroundColor(totalValueForegroundColor)
                    
                    Spacer()
                    
                    Button(action: {
                        self.nextCurrency()
                    }) {
                        Image("arrowRightLight")
                    }
                        .buttonStyle(PlainButtonStyle())
                }
                    .padding([.leading, .trailing])
                
                Text(change)
                    .font(changeFont)
                    .foregroundColor(changeForegroundColor)
            }
        }
        .padding()
    }
    
    private func previousCurrency() {
        switch valueCurrencyViewSate {
        case .fiat:
            valueCurrencyViewSate = .eth
        case .btc:
            valueCurrencyViewSate = .fiat
        case .eth:
            valueCurrencyViewSate = .btc
        }
    }
    private func nextCurrency() {
        switch valueCurrencyViewSate {
        case .fiat:
            valueCurrencyViewSate = .btc
        case .btc:
            valueCurrencyViewSate = .eth
        case .eth:
            valueCurrencyViewSate = .fiat
        }
    }
}

#if DEBUG
struct MarketValueControlsView_Previews: PreviewProvider {
    static var previews: some View {
        MarketValueControlsView(
            valueCurrencyViewSate: .constant(.fiat),
            change: .constant("+$32.21 (10.2%)"),
            totalValue: .constant("$3273.21"),
            type: .constant(.portfolio)
        )
            .previewLayout(PreviewLayout.sizeThatFits)
            .background(Color.portalBackground.edgesIgnoringSafeArea(.all))
    }
}
#endif
