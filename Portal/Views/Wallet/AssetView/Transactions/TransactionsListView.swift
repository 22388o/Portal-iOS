//
//  TransactionsListView.swift
//  Portal
//
//  Created by Farid on 16.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct TransactionItem: Identifiable {
    var id: String
    init() {
        id = UUID().uuidString
    }
}

struct TransactionsListView: View {
//    @FetchRequest(
//        entity: DBWallet.entity(),
//        sortDescriptors: [],
//        predicate: NSPredicate(format: "current = %d", true)
//    ) var currentWallet: FetchedResults<DBWallet>
    
    private let coin: Coin
    @State private var showTxInfo: Bool = false
    
    init(coin: Coin) {
        self.coin = coin
    }
    
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
            
            List(txs) { _ in
                TransactionListItemView(symbol: self.coin.code)
                    .onTapGesture {
                        self.showTxInfo.toggle()
                }
                .padding([.top, .bottom], 6)
            }
            .padding(.top, -8)
            .sheet(isPresented: self.$showTxInfo) {
                TransactionView(coin: self.coin)
            }
        }
    }
}

#if DEBUG
struct TransactionsPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsListView(coin: Coin(code: "ETH", name: "Ethereum"))
            .background(Color.portalBackground.edgesIgnoringSafeArea(.all))
    }
}
#endif
