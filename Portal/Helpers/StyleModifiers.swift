//
//  StyleModifiers.swift
//  Portal
//
//  Created by Farid on 25.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct PButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(8)
            .background(Color.assetViewButton)
            .cornerRadius(18)
            .font(Font.mainFont(size: 16))
            .foregroundColor(.white)
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(Color.assetViewButton, lineWidth: 1)
            )
    }
}

struct ExchangerTextField: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.exchangerFieldBackground)
            .cornerRadius(26)
            .overlay(
                RoundedRectangle(cornerRadius: 26)
                .stroke(Color.exchangerFieldBorder, lineWidth: 1)
            )
    }
}