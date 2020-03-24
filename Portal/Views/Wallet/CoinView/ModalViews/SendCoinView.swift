//
//  SendCoinView.swift
//  Portal
//
//  Created by Farid on 11.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct SendCoinView: View {
    @State var amountInCrypto: String = ""
    @State var amountInFiat: String = ""
    @State var sendToAddress: String = ""

    
    private let model: WalletItemViewModel
    
    init(viewModel: WalletItemViewModel = CoinMock()) {
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
                Text("Send \(model.name)")
                    .font(Font.mainFont(size: 23))
                    .foregroundColor(Color.lightActiveLabel)
                Text("Instantly send to any \(model.symbol) address")
                    .font(Font.mainFont())
                    .foregroundColor(Color.lightActiveLabel)
                    .opacity(0.6)
            }
            
            Spacer().frame(height: 8)
            
            HStack {
                Text("You have")
                    .font(Font.mainFont())
                    .foregroundColor(Color.lightActiveLabel)
                    .opacity(0.6)
                
                Text("\(model.amount) \(model.symbol)")
                    .font(Font.mainFont(size: 14))
                    .foregroundColor(Color.lightActiveLabel)
                
                Button("send all") {
                    
                }
                    .padding([.trailing, .leading], 8)
                    .padding([.top, .bottom], 4)
                    .background(Color.assetViewButton)
                    .cornerRadius(12)
                    .font(Font.mainFont(size: 12))
                    .foregroundColor(.white)
            }
            
            Spacer().frame(height: 16)
            
            VStack(alignment: .leading) {
                Text("Amount to send")
                    .font(Font.mainFont())
                    .foregroundColor(Color.lightActiveLabel)
                    .opacity(0.6)
                
                TextField("Enter amount...", text: $amountInCrypto)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding([.leading, .trailing], 8)
            
            VStack(alignment: .leading) {
                Text("Amount in fiat")
                    .font(Font.mainFont())
                    .foregroundColor(Color.lightActiveLabel)
                    .opacity(0.6)
                
                TextField("Enter amount...", text: $amountInFiat)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding([.leading, .trailing], 8)
            
//            Spacer().frame(height: 16)
            
            VStack(alignment: .leading) {
                Text("Send to...")
                    .font(Font.mainFont())
                    .foregroundColor(Color.lightActiveLabel)
                    .opacity(0.6)
                
                Spacer().frame(height: 16)
                
                Text("Tap to paste \(model.symbol) address")
                    .font(Font.mainFont(size: 16))
                    .foregroundColor(Color.lightActiveLabel)
                    .frame(maxWidth: .infinity)
            }
            .padding([.leading, .trailing], 8)

            Spacer()
            
            Button("Send") {
                
            }
            .modifier(PButtonStyle())
            .padding()
        }
        .padding()
    }
}

#if DEBUG
struct SendCoinsView_Previews: PreviewProvider {
    static var previews: some View {
        SendCoinView(viewModel: BTC())
    }
}
#endif
 
