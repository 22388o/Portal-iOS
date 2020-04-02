//
//  TestSeedView.swift
//  Portal
//
//  Created by Farid on 31.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct TestSeedView: View {
    private var indexes = [Int]()
    
    init() {
        while indexes.count <= 3 {
            let 🎲 = Int.random(in: 1..<24)
            if !indexes.contains(🎲) { indexes.append(🎲) }
        }
    }
    
    var body: some View {
        VStack {
            Title(
                iconName: "iconSafe",
                title: "Confirm the seed",
                subtitle: "Let’s see if you wrote the seed correctly: enter the following words from your seed."
            )
            Spacer()
            VStack {
                ForEach(0 ..< indexes.count) {
                    ConfirmSeedInputView(wordIndex: self.indexes[$0])
                }
                Text("Your wallet will be ready when words are correct.")
                    .font(Font.mainFont(size: 14))
                    .foregroundColor(Color.createWalletLabel)
                    .frame(maxHeight: .infinity)
                Spacer()
                VStack(spacing: 16) {
                    Button("Create") {}.modifier(PButtonStyle())
                    Button("Generate new seed") {}
                }
            }.padding()
        }
    }
}

#if DEBUG
struct TestSeedView_Previews: PreviewProvider {
    static var previews: some View {
        TestSeedView()
    }
}
#endif
