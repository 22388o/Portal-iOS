//
//  Title.swift
//  Portal
//
//  Created by Farid on 02.04.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct Title: View {
    private var icon: String
    private var title: String
    private var subtitle: String
    
    init(icon: String, title: String, subtitle: String) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
    }
    
    var body: some View {
        VStack(spacing: 8) {
            Image(icon)
            Text(title)
                .font(Font.mainFont(size: 30))
                .foregroundColor(Color.createWalletLabel)
            Text(subtitle)
                .font(Font.mainFont(size: 18))
                .foregroundColor(Color.coinViewRouteButtonActive).opacity(0.85)
                .multilineTextAlignment(.center)
        }
    }
}

#if DEBUG
struct Title_Previews: PreviewProvider {
    static var previews: some View {
        Title(
            icon: "iconSafe",
            title: "Title",
            subtitle: "Subtitle"
        )
        .previewLayout(PreviewLayout.sizeThatFits)
        .padding()
    }
}
#endif
