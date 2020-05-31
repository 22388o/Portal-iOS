//
//  BackgroundView.swift
//  Portal
//
//  Created by Farid on 29.05.2020.
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

