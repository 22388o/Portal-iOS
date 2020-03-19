//
//  TransactionView.swift
//  Portal
//
//  Created by Farid on 17.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI


struct TransactionView: View {
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 30)
            VStack {
                Image(uiImage: UIImage(named: "iconBtc")!)
                    .resizable()
                    .frame(width: 48, height: 48)
                Text("Transaction details")
                    .font(.custom("Avenir-Medium", size: 14))
                    .foregroundColor(Color.lightActiveLabel)
                    .opacity(0.6)
                Text("Received 0.0125 BTC")
                    .font(.custom("Avenir-Medium", size: 23))
                    .foregroundColor(Color.lightActiveLabel)
                Text("19 Feb, 2020 at 4:49 PM (28 days ago)")
                    .font(.custom("Avenir-Medium", size: 12))
                    .foregroundColor(Color.lightActiveLabel)
                    .opacity(0.6)
            }
            Spacer()
                .frame(height: 80)
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading) {
                    Text("From")
                        .font(.custom("Avenir-Medium", size: 12))
                        .foregroundColor(Color.lightActiveLabel)
                    Text("0x63a0eefba92957c8284621cf498a0b853c4cad1f")
                        .font(.custom("Avenir-Medium", size: 12))
                }
                VStack(alignment: .leading) {
                    Text("To")
                        .font(.custom("Avenir-Medium", size: 12))
                        .foregroundColor(Color.lightActiveLabel)
                    Text("0x63a0eefba92957c8284621cf498a0b853c4cad1f")
                        .font(.custom("Avenir-Medium", size: 12))
                }
                VStack(alignment: .leading) {
                    Text("Hash")
                        .font(.custom("Avenir-Medium", size: 12))
                        .foregroundColor(Color.lightActiveLabel)
                    Text("0xb34b7ce225bf3386dd9471f632cd9e99f870dc7b9c579222d78fb65dab6abf05")
                        .font(.custom("Avenir-Medium", size: 12))
                }
                VStack(alignment: .leading) {
                    Text("Status")
                        .font(.custom("Avenir-Medium", size: 12))
                        .foregroundColor(Color.lightActiveLabel)
                    Text("Done")
                        .font(.custom("Avenir-Medium", size: 12))
                }
                VStack(alignment: .leading) {
                    Text("Confirmations")
                        .font(.custom("Avenir-Medium", size: 12))
                        .foregroundColor(Color.lightActiveLabel)
                    Text("234865")
                        .font(.custom("Avenir-Medium", size: 12))
                }
                VStack(alignment: .leading) {
                    Text("Note")
                        .font(.custom("Avenir-Medium", size: 12))
                        .foregroundColor(Color.lightActiveLabel)
                    Text("-")
                        .font(.custom("Avenir-Medium", size: 12))
                }
                Spacer()
            }
            .padding()
            Button("View transaction in block explorer") { /*self.showSendView.toggle()*/ }
                .modifier(PButtonStyle())
                .padding()

        }
        .padding()

    }
}

#if DEBUG
struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView()
    }
}
#endif
