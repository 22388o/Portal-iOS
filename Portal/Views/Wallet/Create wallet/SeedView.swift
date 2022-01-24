//
//  SeedView.swift
//  Portal
//
//  Created by Farid on 30.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct SeedView: View {
    @State private var showTestSeedView = false
    private var newWalletModel: NewWalletModel
    
    init(newWalletModel: NewWalletModel) {
        self.newWalletModel = newWalletModel
    }

    var body: some View {
        VStack(spacing: 14) {
            NavigationLink(
                destination: TestSeedView(newWalletModel: newWalletModel),
                isActive: self.$showTestSeedView
            ) {
              EmptyView()
            }
                .hidden()
                .onAppear() {
                    self.showTestSeedView = false
                }
            
            HStack {
                Image("iconSafe")
                VStack(alignment: .leading, spacing: 4) {
                    Text("Save your seed")
                        .font(Font.mainFont(size: 23))
                    Text("Store the seed")
                        .font(Font.mainFont(size: 15))
                }
                    .foregroundColor(Color.createWalletLabel)
            }
            Text("Make 100% sure you have all the words, in that same order, and continue when you’re ready.")
                .font(Font.mainFont(size: 15))
                .foregroundColor(Color.createWalletLabel)
            SeedContainerView(seed: newWalletModel.seed)
            Button("Next"){
                self.showTestSeedView = true
            }
                .modifier(PButtonEnabledStyle(enabled: .constant(true)))
        }
        .hideNavigationBar()
        .padding()
    }
}
#if DEBUG
struct SeedView_Previews: PreviewProvider {
    static var previews: some View {
        SeedView(newWalletModel: .init(name: "Test"))
    }
}
#endif

struct SeedContainerView: View {
    var seed: [String]
    var body: some View {
        HStack {
            VStack(spacing: 16) {
                ForEach(0 ..< seed.count/2) { index in
                    HStack {
                        Text("\(index + 1))")
                            .font(Font.mainFont(size: 16))
                            .foregroundColor(Color.blush)
                        Text(self.seed[index])
                            .font(Font.mainFont(size: 16))
                            .foregroundColor(Color.brownishOrange)
                    }
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
            VStack(spacing: 16) {
                ForEach(seed.count/2 ..< seed.count) { index in
                    HStack {
                        Text("\(index + 1))")
                            .font(Font.mainFont(size: 16))
                            .foregroundColor(Color.blush)
                        Text(self.seed[index])
                            .font(Font.mainFont(size: 16))
                            .foregroundColor(Color.brownishOrange)
                    }
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(8)
        .background(Color.mnemonicBackground)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.mango, lineWidth: 2)
        )
    }
}

