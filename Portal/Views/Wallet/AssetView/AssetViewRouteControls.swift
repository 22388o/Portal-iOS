//
//  AssetViewRouteControls.swift
//  Portal
//
//  Created by Farid on 13.07.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct AssetViewRouteControls: View {
    private let titeFont: Font = .mainFont(size: 15)
    private let viewWidth: CGFloat = 110
    private let topTadding: CGFloat = 12
       
    @Binding var route: CoinViewRoute
    
    var body: some View {
        HStack(alignment: .center) {
            Group {
                Button(action: { self.route = .value }) {
                    Text("Value")
                        .foregroundColor(route == .value ? Color.coinViewRouteButtonInactive : Color.coinViewRouteButtonActive)
                }
                
                Button(action: { self.route = .transactions }) {
                    Text("Transactions")
                        .foregroundColor(route == .transactions ?  Color.coinViewRouteButtonInactive : Color.coinViewRouteButtonActive)
                }
                
                Button(action: { self.route = .alerts }) {
                    Text("Alerts")
                        .foregroundColor(route == .alerts ? Color.coinViewRouteButtonInactive : Color.coinViewRouteButtonActive)
                }
            }
            .frame(width: viewWidth)
        }
        .font(titeFont)
        .padding(.top, topTadding)
    }
}

#if DEBUG
struct AssetViewRouteControls_Previews: PreviewProvider {
    static var previews: some View {
        AssetViewRouteControls(route: .constant(.value))
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .background(Color.portalBackground.edgesIgnoringSafeArea(.all))
    }
}
#endif
