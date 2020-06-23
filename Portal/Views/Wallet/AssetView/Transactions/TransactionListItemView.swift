//
//  TransactionListItemView.swift
//  Portal
//
//  Created by Farid on 17.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct TransactionListItemView: View {
    var symbol: String
    
    init(symbol: String) {
        self.symbol = symbol
    }
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                HStack {
                    Text(Bool.random() ? "Sent" : "Received")
                    Spacer()
                }
                
                HStack(alignment: .center) {
                    Text("\(Double.random(in: 0.001 ..< 1.125)) \(symbol)")
                        .foregroundColor(Color.white)
                }
                
                HStack(alignment: .center) {
                    Spacer()
                    Text("1 month ago")
                }
            }
                .frame(maxWidth: .infinity)
                .foregroundColor(Color.coinViewRouteButtonInactive)
                .font(Font.mainFont())
                .padding([.trailing, .leading])
        }
    }
}

#if DEBUG
struct TransactionListItemView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListItemView(symbol: "BTC").background(Color.gray)
    }
}
#endif
