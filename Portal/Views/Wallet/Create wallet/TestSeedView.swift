//
//  TestSeedView.swift
//  Portal
//
//  Created by Farid on 31.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI
import Combine

struct TestSeedView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var walletCoordinator: WalletCoordinator
    @ObservedObject private var viewModel: TestSeedViewModel
    @State private var walletCreated = false
    
    @State private var index0 = 0
    @State private var index1 = 1
    @State private var index2 = 2
    @State private var index3 = 3
    
    init(newWalletModel: NewWalletModel) {
        self.viewModel = .init(newWalletModel: newWalletModel)
    }
    
    var body: some View {
        VStack {
            NavigationLink(
                destination: WalletCreatedView(),
                isActive: self.$walletCreated
            ) {
              EmptyView()
            }
                .hidden()

            Title(
                icon: "iconSafe",
                title: "Confirm the seed",
                subtitle: "Let’s see if you wrote the seed correctly: enter the following words from your seed."
            )
            Spacer()
            VStack {
                ConfirmSeedInputView(inputString: $viewModel.testString1, wordIndex: $index0)
                ConfirmSeedInputView(inputString: $viewModel.testString2, wordIndex: $index1)
                ConfirmSeedInputView(inputString: $viewModel.testString3, wordIndex: $index2)
                ConfirmSeedInputView(inputString: $viewModel.testString4, wordIndex: $index3)

                Text(
                    viewModel.formIsValid ?
                        "You wallet is ready!"
                            :
                        "Your wallet will be ready when words are correct."
                )
                    .font(Font.mainFont(size: 14))
                    .foregroundColor(Color.createWalletLabel)
                    .frame(maxHeight: .infinity)
                Spacer()
                VStack(spacing: 16) {
                    Button("Create") {
                        self.walletCoordinator.createWallet(model: self.viewModel.newWalletModel)
                    }
                    .modifier(PButtonEnabledStyle(enabled: $viewModel.formIsValid))
                    .disabled(!viewModel.formIsValid)

                    Button("Generate new seed") {
                        self.mode.wrappedValue.dismiss()
                    }
                }
            }
                .padding()
        }
            .hideNavigationBar()
            .keyboardResponsive()
            .onAppear {
                self.viewModel.setup()
                self.updateIndices()
                print("Test solved: \(self.viewModel.testSolved)")
            }
            .onReceive(walletCoordinator.$currentWallet, perform: { newWallet in
                guard newWallet != nil else { return }
                self.walletCreated.toggle()
            })
    }
    
    private func updateIndices() {
        index0 = viewModel.testIndices[0]
        index1 = viewModel.testIndices[1]
        index2 = viewModel.testIndices[2]
        index3 = viewModel.testIndices[3]
    }
}

#if DEBUG
struct TestSeedView_Previews: PreviewProvider {
    static var previews: some View {
        TestSeedView(newWalletModel: .init(name: "Test")).environmentObject(WalletCoordinator())
    }
}
#endif
