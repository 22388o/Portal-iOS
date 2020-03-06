//
//  CoinDetailsView.swift
//  Portal
//
//  Created by Farid on 06.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct CoinDetailsView: View {
    @Binding var showModal: Bool
    @Binding var model: WalletItemViewModel
    
    var body: some View {
        VStack {
            Text("\(model.symbol) Details")
                .padding()
            Button("Dismiss") {
                self.showModal.toggle()
            }
        }
    }
}

struct CoinDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CoinDetailsView(showModal: .constant(true), model: .constant(CoinMock()))
    }
}
