//
//  TimeframeButtonsView.swift
//  Portal
//
//  Created by Farid on 26.05.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct TimeframeButtonsView: View {
    @Binding var type: AssetMarketValueViewType
    @Binding var timeframe: Timeframe

    var body: some View {
        HStack {
            Button(action: {
                self.timeframe = .day
            }) {
                Text("Day")
                    .modifier(
                        TimeframeButton(type: type, isSelected: timeframe == .day)
                )
            }
            
            Button(action: {
                self.timeframe = .week
            }) {
                Text("Week")
                    .modifier(
                        TimeframeButton(type: type, isSelected: timeframe == .week)
                )
            }
            Button(action: {
                self.timeframe = .month
            }) {
                Text("Month")
                    .modifier(
                        TimeframeButton(type: type, isSelected: timeframe == .month)
                )
            }
            
            Button(action: {
                self.timeframe = .year
            }) {
                Text("Year")
                    .modifier(
                        TimeframeButton(type: type, isSelected: timeframe == .year)
                )
            }
        }
        .padding([.leading, .trailing])
    }
}

#if DEBUG
struct TimeframeButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        TimeframeButtonsView(
            type: .constant(.portfolio),
            timeframe: .constant(.day)
        )
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .background(Color.portalBackground.edgesIgnoringSafeArea(.all))
    }
}
#endif
