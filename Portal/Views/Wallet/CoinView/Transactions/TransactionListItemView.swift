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
        HStack {
            HStack() {
                Text(Bool.random() ? "Sent" : "Received")
                    .font(Font.mainFont())
                    .foregroundColor(Color.txListTxType)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            
            HStack(alignment: .center) {
                Text("\(Double.random(in: 0.001 ..< 1.125)) \(symbol)")
                    .font(Font.mainFont())
                    .foregroundColor(Color.coinViewRouteButtonActive)
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
    }
}

#if DEBUG
struct TransactionListItemView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListItemView(symbol: "BTC")
    }
}
#endif
