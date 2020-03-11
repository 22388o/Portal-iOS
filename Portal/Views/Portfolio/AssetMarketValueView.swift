//
//  AssetMarketValueView.swift
//  Portal
//
//  Created by Farid on 10.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct AssetMarketValueView: View {
    let viewModel: PortfolioViewModel = PortfolioViewModel()

    var body: some View {
        VStack {
            HStack(spacing: 10) {
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
            .padding()
            
            VStack {
                Text(viewModel.totalValue).font(.largeTitle)
                Text("Change")
            }
            .padding()
            
            LineChartUIKitWrapper()
                .frame(height: 150)
                .padding()
            
            HStack(spacing: 80) {
                VStack(spacing: 10) {
                    Text("High")
                    Text("$0.0")
                }
                .padding()
                
                VStack(spacing: 10) {
                    Text("Low")
                    Text("$0.0")
                }
                .padding()
            }
        }
    }
}

#if DEBUG
struct AssetMarketValueView_Previews: PreviewProvider {
    static var previews: some View {
        AssetMarketValueView()
    }
}
#endif
