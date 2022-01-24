//
//  AssetItemView.swift
//  Portal
//
//  Created by Farid on 06.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct AssetItemView: View {
    
    private let iconSize: CGFloat = 24
    private let verticalSpacing: CGFloat = 6
    private let titleFont: Font = .mainFont(size: 18)
    private let subtitleFont: Font = .mainFont(size: 14)
    private let subtitleForegroundColor = Color.white.opacity(0.6)
    private let backgroundColor = Color.black.opacity(0.25)
    private let cornerRadius: CGFloat = 16
    
    @ObservedObject private var asset: AssetItemViewModel
            
    init(_ viewModel: AssetItemViewModel) {
        self.asset = viewModel
    }
    
    private var emptyView: some View {
        HStack {
            EmptyView()
        }
            .frame(minWidth: 0, maxWidth: .infinity)
    }
    
    var body: some View {
        HStack(alignment: .center) {
            Image(uiImage: asset.icon)
                .resizable()
                .frame(width: iconSize, height: iconSize)
                .padding([.leading])
            
            VStack(spacing: verticalSpacing) {
                HStack {
                    Text(asset.code)
                    emptyView
                    Text(asset.balance)
                }
                    .font(titleFont)
                    .foregroundColor(Color.white)
                
                HStack {
                    Text(asset.name)
                    emptyView
                    Text(asset.totalValue)

                }
                    .font(subtitleFont)
                .foregroundColor(subtitleForegroundColor)

                
                HStack {
                    Text(asset.price)
                    emptyView
                    Text(asset.change)
                }
                    .font(subtitleFont)
                    .foregroundColor(subtitleForegroundColor)
            }
                .padding([.trailing, .top, .bottom], 15)
                .padding(.leading, 5)
        }
        .background(backgroundColor)
        .cornerRadius(cornerRadius)
            .onAppear(perform: {
                print("\(self.asset.code) on Appear")
            })
            .onDisappear(perform: {
                print("\(self.asset.code) on Disappear")
            })
    }
}

#if DEBUG
struct AssetItemView_Previews: PreviewProvider {
    static var previews: some View {
        AssetItemView(
            AssetItemViewModel(asset:
                Asset(
                    coin: Coin(
                        code: "BTC",
                        name: "Bitcoin",
                        icon: UIImage(imageLiteralResourceName: "iconBtc")
                    )
                )
            )
        )
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .background(Color.portalBackground.edgesIgnoringSafeArea(.all))
    }
}
#endif
