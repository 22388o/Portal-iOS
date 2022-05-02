//
//  CreateWalletView.swift
//  Portal
//
//  Created by Farid on 30.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct CreateWalletView: View {
    @State private var showSeedView: Bool = false
    
    @ObservedObject var viewModel: CreateWalletViewModel
    
    init() {
        self.viewModel = CreateWalletViewModel()
    }
    
    var body: some View {
        VStack {
            NavigationLink(
                destination: SeedView(
                    newWalletModel: viewModel.newModel()
                ),
                isActive: self.$showSeedView
            ) {
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
                        TextField("Enter wallet name", text: $viewModel.name)
                            .textFieldStyle(PlainTextFieldStyle())
                            .font(Font.mainFont(size: 16))
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
                        Picker("Numbers", selection: $viewModel.selectorIndex) {
                            ForEach(0 ..< BtcAddressFormat.allCases.count) { index in
                                Text(BtcAddressFormat.allCases[index].description).tag(index)
                            }
                        }
                            .pickerStyle(SegmentedPickerStyle())
                    }
                    Spacer()
            }
                .frame(maxHeight: .infinity)
        }
        Spacer()
            VStack(spacing: 12) {
                Button("Create") {
                    self.showSeedView.toggle()
                }
                    .modifier(PButtonEnabledStyle(enabled: $viewModel.walletDataValidated))
                    .disabled(!viewModel.walletDataValidated)
                
                HStack {
                    Text("Already have a wallet?")
                        .font(Font.mainFont(size: 14))
                    Button("Restore it") {
                        
                    }
                }
            }
        }
        .padding()
        .onAppear {
            self.viewModel.setup()
        }
    }
}
#if DEBUG
struct CreateWalletView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CreateWalletView()//.environment(\.colorScheme, .dark)
                .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
                .previewDisplayName("iPhone SE")
            
            CreateWalletView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
                .previewDisplayName("iPhone 11 Pro")
            
            CreateWalletView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
                .previewDisplayName("iPhone 11 Pro Max")
        }
        
    }
}
#endif
