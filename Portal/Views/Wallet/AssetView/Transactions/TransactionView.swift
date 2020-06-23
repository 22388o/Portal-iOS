//
//  TransactionView.swift
//  Portal
//
//  Created by Farid on 17.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI


struct TransactionView: View {
    let coin: Coin
    
    init(coin: Coin = Coin(code: "ETH", name: "Ethereum")) {
        self.coin = coin
    }
    
    var body: some View {
        ZStack {
            Color.portalBackground.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer().frame(height: 8)
                VStack {
                    Image(uiImage: coin.icon)
                        .resizable()
                        .frame(width: 80, height: 80)
                    Text("Transaction details")
                        .font(Font.mainFont(size: 14))
                        .opacity(0.6)
                    Text("Received 0.0125 \(coin.code)")
                        .font(Font.mainFont(size: 23))
                    Text("19 Feb, 2020 at 4:49 PM (28 days ago)")
                        .font(Font.mainFont())
                        .opacity(0.6)
                }
                    .foregroundColor(Color.white)
                
                Spacer().frame(height: 30)
                VStack {
                    VStack {
                        VStack(alignment: .leading, spacing: 20) {
                            VStack(alignment: .leading) {
                                Text("From").opacity(0.6)
                                Text("1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2")
                            }
                            VStack(alignment: .leading) {
                                Text("To").opacity(0.6)
                                Text("3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy")
                            }
                            VStack(alignment: .leading) {
                                Text("Hash").opacity(0.6)
                                Text("a1075db55d416d3ca199f55b6084e2115b9345e16c5cf302fc80e9d5fbf5d48d")
                            }
                            VStack(alignment: .leading) {
                                Text("Status").opacity(0.6)
                                Text("Done")
                            }
                            VStack(alignment: .leading) {
                                Text("Confirmations").opacity(0.6)
                                Text("234865")
                            }
                            VStack(alignment: .leading) {
                                Text("Note").opacity(0.6)
                                Text("-")
                            }
                        }
                            .foregroundColor(Color.white)
                            .padding()
                                            
                        Spacer()
                    }
                        .font(Font.mainFont())
                    
                    Button("View transaction in block explorer") {
                    
                    }
                    .modifier(PButtonEnabledStyle(enabled: .constant(true)))
                    .padding()
                
                }
                .frame(width: UIScreen.main.bounds.width)
            }
            .padding()
        }
    }
}

#if DEBUG
struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView(coin: Coin(code: "BTC", name: "Bitcoin", color: UIColor.yellow, icon: UIImage(imageLiteralResourceName: "iconBtc")))
//            .background(Color.portalBackground.edgesIgnoringSafeArea(.all))
    }
}
#endif
