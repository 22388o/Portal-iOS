//
//  ConfirmSeedInputView.swift
//  Portal
//
//  Created by Farid on 02.04.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

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

#if DEBUG
struct ConfirmSeedInputView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmSeedInputView()
    }
}
#endif
