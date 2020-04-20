//
//  TransactionView.swift
//  Portal
//
//  Created by Farid on 17.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI


struct TransactionView: View {
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
                Text("Transaction details")
                    .font(Font.mainFont(size: 14))
                    .foregroundColor(Color.lightActiveLabel)
                    .opacity(0.6)
                Text("Received 0.0125 \(model.symbol)")
                    .font(Font.mainFont(size: 23))
                    .foregroundColor(Color.lightActiveLabel)
                Text("19 Feb, 2020 at 4:49 PM (28 days ago)")
                    .font(Font.mainFont())
                    .foregroundColor(Color.lightActiveLabel)
                    .opacity(0.6)
            }
            Spacer()
                .frame(height: 30)
            VStack {
                VStack {
                    VStack(alignment: .leading, spacing: 20) {
                        VStack(alignment: .leading) {
                            Text("From")
                                .font(Font.mainFont())
                                .foregroundColor(Color.lightActiveLabel)
                            Text("0x63a0eefba92957c8284621cf498a0b853c4cad1f")
                                .font(Font.mainFont())
                        }
                        VStack(alignment: .leading) {
                            Text("To")
                                .font(Font.mainFont())
                                .foregroundColor(Color.lightActiveLabel)
                            Text("0x63a0eefba92957c8284621cf498a0b853c4cad1f")
                                .font(Font.mainFont())
                        }
                        VStack(alignment: .leading) {
                            Text("Hash")
                                .font(Font.mainFont())
                                .foregroundColor(Color.lightActiveLabel)
                            Text("0xb34b7ce225bf3386dd9471f632cd9e99f870dc7b9c579222d78fb65dab6abf05")
                                .font(Font.mainFont())
                        }
                        VStack(alignment: .leading) {
                            Text("Status")
                                .font(Font.mainFont())
                                .foregroundColor(Color.lightActiveLabel)
                            Text("Done")
                                .font(Font.mainFont())
                        }
                        VStack(alignment: .leading) {
                            Text("Confirmations")
                                .font(Font.mainFont())
                                .foregroundColor(Color.lightActiveLabel)
                            Text("234865")
                                .font(Font.mainFont())
                        }
                        VStack(alignment: .leading) {
                            Text("Note")
                                .font(Font.mainFont())
                                .foregroundColor(Color.lightActiveLabel)
                            Text("-")
                                .font(Font.mainFont())
                        }
                    }
                    .padding()
                    
                    Spacer()
                }
                .background(Color(red: 245.0/255.0, green: 245.0/255.0, blue: 248.0/255.0))
                
                Button("View transaction in block explorer") { /*self.showSendView.toggle()*/ }
                    .modifier(PButtonStyle())
                    .padding()
                
            }
            .frame(width: UIScreen.main.bounds.width)
        }
        .padding()

    }
}

#if DEBUG
struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView(viewModel: ETH().viewModel)
    }
}
#endif
