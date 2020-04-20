//
//  ReceiveCoinView.swift
//  Portal
//
//  Created by Farid on 11.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct ReceiveCoinView: View {
    let model: CoinViewModel
    
    init(viewModel: CoinViewModel = CoinMock()) {
        self.model = viewModel
    }
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 8)
            VStack {
                Image(uiImage: model.icon)
                    .resizable()
                    .frame(width: 80, height: 80)
                Text("Receive \(model.name)")
                    .font(Font.mainFont(size: 23))
                    .foregroundColor(Color.lightActiveLabel)
            }    
            VStack {
                Image(uiImage: model.QRCode())
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width - 80, height: UIScreen.main.bounds.width - 80)

                VStack(alignment: .center, spacing: 10) {
                    Text("Your \(model.symbol) address")
                        .font(Font.mainFont(size: 14))
                        .foregroundColor(Color.lightActiveLabel)
                        .opacity(0.6)
                    Text(btcMockAddress)
                        .scaledToFill()
                        .font(Font.mainFont(size: 16))
                        .foregroundColor(Color.lightActiveLabel)
                    Spacer()
                }
                .padding()
            }
            .frame(maxHeight: .infinity)
            
            Button("Share") {}
                .modifier(PButtonStyle())
                .padding()
        }
        .padding()
    }
}

#if DEBUG
struct ReceiveCoinView_Previews: PreviewProvider {
    static var previews: some View {
        ReceiveCoinView(viewModel: BTC().viewModel)
    }
}
#endif
