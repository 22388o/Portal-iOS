//
//  PortfolioView.swift
//  Portal
//
//  Created by Farid on 06.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct PortfolioView: View {
    @Binding var showModal: Bool
    
    var body: some View {
        VStack {
            Text("Portfolio")
                .padding()
            Button("Dismiss") {
                self.showModal.toggle()
            }
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView(showModal: .constant(true))
    }
}
