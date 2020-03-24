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
    @State private var showTxInfo: Bool = false
    
    var body: some View {
        VStack {
            List(0 ..< 20) { index in
                TransactionListItemView(symbol: self.model.symbol)
                    .onTapGesture {
                        self.showTxInfo.toggle()
                }
            }
            .padding(.top, -8)
            .sheet(isPresented: self.$showTxInfo) {
                TransactionView(viewModel: self.model)
            }
        }
    }
}

#if DEBUG
struct TransactionsPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsListView(model: .constant(BTC()))
    }
}
#endif
