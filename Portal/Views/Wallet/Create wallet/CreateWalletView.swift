//
//  CreateWalletView.swift
//  Portal
//
//  Created by Farid on 30.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct CreateWalletView: View {
    @State private var walletName: String = ""
    @State private var legacy: Bool = false
    @State private var numbers = ["Legacy","SegWit","Native SegWit"]
    @State private var selectorIndex = 1
    @State var pushActive = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: SeedView(), isActive: self.$pushActive) {
                  EmptyView()
                }
                .hidden()
                
                VStack(spacing: 20) {
                    Title(
                        iconName: "iconSafe",
                        title: "Create a wallet",
                        subtitle: "Store more than 2000 different currencies locally. Only you hold your private keys. Secure and private."
                    )
                    Divider()
                    VStack(spacing: 20) {
                        Text("Name your wallet")
                            .font(Font.mainFont(size: 17))
                            .foregroundColor(Color.createWalletLabel)
                        Text("We suggest using your name, or simple words like ‘Personal’, ‘Work’, ‘Investments’ etc.")
                            .font(Font.mainFont(size: 14))
                            .foregroundColor(Color.coinViewRouteButtonActive)
                            .multilineTextAlignment(.center)
                        HStack(spacing: 8) {
                            Image("iconSafeSmall")
                                .resizable()
                                .frame(width: 24, height: 24)
                            TextField("Enter wallet name", text: $walletName)
                                .textFieldStyle(PlainTextFieldStyle())
                                .font(Font.mainFont(size: 16))
//                                .keyboardType(.numberPad)
                        }
                        .modifier(TextFieldModifier())
                        .padding([.leading, .trailing], 4)
                                                
                        VStack(spacing: 20) {
                            Text("Bitcoin address format")
                                .font(Font.mainFont(size: 17))
                                .foregroundColor(Color.createWalletLabel)
                            Text("With SegWit addresses the network can process more transactions per block and the sender pays lower transaction fees.")
                                .font(Font.mainFont(size: 14))
                                .foregroundColor(Color.coinViewRouteButtonActive)
                                .multilineTextAlignment(.center)
                                .frame(maxHeight: .infinity)
                            Picker("Numbers", selection: $selectorIndex) {
                                ForEach(0 ..< numbers.count) { index in
                                    Text(self.numbers[index]).tag(index)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        
                        Spacer()

                    }.frame(maxHeight: .infinity)
                }
                Spacer()
                VStack(spacing: 12) {
                    Button("Create") {
                        self.pushActive.toggle()
                    }
                    .modifier(PButtonStyle())
                    
                    HStack {
                        Text("Already have a wallet?")
                            .font(Font.mainFont(size: 14))
                        Button("Restore it") {
                            
                        }
                    }
                }
            }
            .navigationBarTitle("Create Wallet")
            .navigationBarHidden(true)
        }
        .padding()
    }
}
#if DEBUG
struct CreateWalletView_Previews: PreviewProvider {
    static var previews: some View {
        CreateWalletView()
    }
}
#endif
