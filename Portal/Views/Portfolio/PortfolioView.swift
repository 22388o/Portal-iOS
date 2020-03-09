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
        GeometryReader { geometry in
            VStack {
                Text("Total portfolio value")
                    .padding()
                HStack(spacing: 20) {
                    Button(action: {
                        
                    }) { Text("Hour") }
                    Button(action: {
                        
                    }) { Text("Day") }
                    Button(action: {
                        
                    }) { Text("Week") }
                    Button(action: {
                        
                    }) { Text("Month") }
                    Button(action: {
                        
                    }) { Text("Year") }
                    Button(action: {
                        
                    }) { Text("All time") }
                }
                Spacer()
                Button("Dismiss") {
                    self.showModal.toggle()
                }
            }
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView(showModal: .constant(true))
    }
}
