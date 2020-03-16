//
//  TransactionsListView.swift
//  Portal
//
//  Created by Farid on 16.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct TransactionsListView: View {
    var body: some View {
        VStack {
            Text("Transactions")
        }
    }
}

#if DEBUG
struct TransactionsPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsListView()
    }
}
#endif
