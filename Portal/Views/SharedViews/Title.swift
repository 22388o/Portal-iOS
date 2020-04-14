//
//  Title.swift
//  Portal
//
//  Created by Farid on 02.04.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct Title: View {
    private var iconName: String = "iconSafe"
    private var title: String = "Title"
    private var subtitle: String = "Subtitle"
    
    init(iconName: String, title: String, subtitle: String) {
        self.iconName = iconName
        self.title = title
        self.subtitle = subtitle
    }
    
    var body: some View {
        VStack(spacing: 8) {
            Image(iconName)
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
        Title(iconName: "iconSafe", title: "Title", subtitle: "Subtitle")
    }
}
#endif
