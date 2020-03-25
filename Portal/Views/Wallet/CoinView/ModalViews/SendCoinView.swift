//
//  SendCoinView.swift
//  Portal
//
//  Created by Farid on 11.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct SendCoinView: View {
    private let model: WalletItemViewModel
    @State var sendToAddress: String = ""
    
    init(viewModel: WalletItemViewModel = CoinMock()) {
        self.model = viewModel
    }
    
    private func endEditing() {
        UIApplication.shared.windows.first?.endEditing(true)
    }
    
    var body: some View {
        Background {
            VStack {
                Spacer()
                    .frame(height: 8)
                VStack {
                    Image(uiImage: self.model.icon)
                        .resizable()
                        .frame(width: 80, height: 80)
                    Text("Send \(self.model.name)")
                        .font(Font.mainFont(size: 23))
                        .foregroundColor(Color.lightActiveLabel)
                    Text("Instantly send to any \(self.model.symbol) address")
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
                    
                    Text("\(self.model.amount) \(self.model.symbol)")
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
                
                ExchangerView(viewModel: self.model)
                
                Spacer().frame(height: 16)
                
                VStack(alignment: .leading) {
                    Text("Send to...")
                        .font(Font.mainFont())
                        .foregroundColor(Color.lightActiveLabel)
                        .opacity(0.6)
                    
                    Spacer().frame(height: 16)
                    
                    VStack {
                        TextField("Enter \(self.model.symbol) address...", text: self.$sendToAddress)
                        .textFieldStyle(PlainTextFieldStyle())
                        .font(Font.mainFont(size: 16))
                    }.modifier(ExchangerTextField())
                }

                Spacer()
                
                Button("Send") {
                    
                }
                .modifier(PButtonStyle())
            }
        }.onTapGesture {
            self.endEditing()
        }
    }
}

#if DEBUG
struct SendCoinsView_Previews: PreviewProvider {
    static var previews: some View {
        SendCoinView(viewModel: BTC())
    }
}
#endif
 
