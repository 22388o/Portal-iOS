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

    var body: some View {
        VStack(spacing: 14) {
            NavigationLink(destination: TestSeedView(), isActive: self.$showTestSeedView) {
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
                        .foregroundColor(Color.createWalletLabel)
                    Text("Store the seed")
                        .font(Font.mainFont(size: 15))
                        .foregroundColor(Color.createWalletLabel)
                }
            }
            Text("Make 100% sure you have all the words, in that same order, and continue when you’re ready.")
                .font(Font.mainFont(size: 15))
                .foregroundColor(Color.createWalletLabel)
            HStack {
                VStack(spacing: 16) {
                    ForEach(1 ..< 13) { index in
                        HStack {
                            Text("\(index))")
                                .font(Font.mainFont(size: 16))
                                .foregroundColor(Color.blush)
                            Text("seed")
                                .font(Font.mainFont(size: 16))
                                .foregroundColor(Color.brownishOrange)
                        }
                    }
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                VStack(spacing: 16) {
                    ForEach(13 ..< 25) { index in
                        HStack {
                            Text("\(index))")
                                .font(Font.mainFont(size: 16))
                                .foregroundColor(Color.blush)
                            Text("seed")
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
            Button("Next"){
                self.showTestSeedView = true
            }.modifier(PButtonStyle())
        }
        .hideNavigationBar()
        .padding()
    }
}
#if DEBUG
struct SeedView_Previews: PreviewProvider {
    static var previews: some View {
        SeedView()
    }
}
#endif
