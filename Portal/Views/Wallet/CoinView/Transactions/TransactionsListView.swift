//
//  TransactionsListView.swift
//  Portal
//
//  Created by Farid on 16.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct TransactionsListView: View {
    @Binding var model: WalletItemViewModel
    
    var body: some View {
        VStack {
            List(0 ..< 20) { index in
                TransactionListItemView(symbol: self.model.symbol)
            }
            .padding(.top, -8)
        }
    }
}

#if DEBUG
struct TransactionsPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsListView(model: .constant(CoinMock()))
    }
}
#endif
