//
//  TransactionsListView.swift
//  Portal
//
//  Created by Farid on 16.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI
import QGrid

struct TransactionItem: Identifiable {
    var id: String
    init() {
        id = UUID().uuidString
    }
}

struct TransactionsListView: View {
    @Binding var model: WalletItemViewModel
    @State private var showTxInfo: Bool = false
    
    var txs: [TransactionItem] {
        var transactions = [TransactionItem]()
        for _ in 0...15 {
            transactions.append(TransactionItem())
        }
        return transactions
    }
    
    var body: some View {
        ZStack {
            Color.clear
            
            QGrid(txs, columns: 1, hSpacing: 0) { adapter in
                TransactionListItemView(symbol: self.model.symbol)
                    .onTapGesture {
                        self.showTxInfo.toggle()
                }.padding([.top, .bottom], 6)
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
