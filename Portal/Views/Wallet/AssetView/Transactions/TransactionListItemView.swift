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
                HStack() {
                    Text(Bool.random() ? "Sent" : "Received")
                        .font(Font.mainFont())
                        .foregroundColor(Color.coinViewRouteButtonInactive)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                
                HStack(alignment: .center) {
                    Text("\(Double.random(in: 0.001 ..< 1.125)) \(symbol)")
                        .font(Font.mainFont())
                        .foregroundColor(Color.white)
                }
                .frame(maxWidth: .infinity)
                
                HStack(alignment: .center) {
                    Spacer()
                    Text("1 month ago")
                        .font(Font.mainFont())
                        .foregroundColor(Color.coinViewRouteButtonInactive)
                }
                .frame(maxWidth: .infinity)
            }
            .padding([.trailing, .leading])
//            Rectangle().frame(height: 0.5)
        }//.frame(height: 34)
    }
}

#if DEBUG
struct TransactionListItemView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListItemView(symbol: "BTC").background(Color.gray)
    }
}
#endif
