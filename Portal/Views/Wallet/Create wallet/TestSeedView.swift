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
    
    init(indexies: [Int] = [Int]()) {
        while indexes.count <= 3 {
            let 🎲 = Int.random(in: 1..<24)
            if !indexes.contains(🎲) { indexes.append(🎲) }
        }
    }
    
    var body: some View {
        VStack {
            Title()
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

struct Title: View {
    var body: some View {
        VStack(spacing: 8) {
            Image("iconSafe")
            Text("Confirm the seed")
                .font(Font.mainFont(size: 30))
                .foregroundColor(Color.createWalletLabel)
            Text("Let’s see if you wrote the seed correctly: enter the following words from your seed.")
                .font(Font.mainFont(size: 18))
                .foregroundColor(Color.coinViewRouteButtonActive).opacity(0.85)
                .multilineTextAlignment(.center)
        }
    }
}

struct ConfirmSeedInputView: View {
    private var index: Int = 0
    @State private var inputString: String = ""
    
    init(wordIndex: Int = 0) {
        index = wordIndex
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("\(index.enumerationFormattedString())")
                .font(Font.mainFont(size: 14))
                .foregroundColor(Color.createWalletLabel)
                .offset(x: 24)
            TextField("Enter word", text: $inputString)
                .textFieldStyle(PlainTextFieldStyle())
                .font(Font.mainFont(size: 16))
                //                    .keyboardType(.numberPad)
                .modifier(TextFieldModifier())
        }
    }
}

#endif
