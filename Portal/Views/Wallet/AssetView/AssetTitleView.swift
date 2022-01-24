//
//  AssetTitleView.swift
//  Portal
//
//  Created by Farid on 13.07.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct AssetTitleView: View {
    private let controlStackSpacing: CGFloat = 10
    private let iconSize: CGFloat = 24
    private let controlStackSize: CGFloat = 75
    private let controlStackSizeSmall: CGFloat = 35
    private let smallStackVerticalSpacing: CGFloat = 0.0
    
    private let titeFont: Font = .mainFont(size: 15)
    private let amountFont: Font = .mainFont(size: 28)

    @ObservedObject private var viewModel: AssetViewModel
       
    private var smallSize: Bool
    
    init(viewModel: AssetViewModel, smallSize: Bool) {
        self.smallSize = smallSize
        self.viewModel = viewModel
    }
    
    private func titleStack(small: Bool) -> some View {
        Group {
            HStack {
                Image(uiImage: viewModel.icon)
                    .resizable()
                    .frame(width: iconSize, height: iconSize)
                Text("\(viewModel.name)")
                    .font(titeFont)
                    .foregroundColor(Color.lightActiveLabel)
            }
            
            if small {
                Spacer()
            }
            
            Text("\(viewModel.balance)")
                .font(amountFont)
                .foregroundColor(Color.coinViewRouteButtonInactive)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: controlStackSpacing) {
            if smallSize {
                HStack {
                    titleStack(small: true)
                }
                .frame(height: controlStackSizeSmall)
            } else {
                VStack(alignment: .leading, spacing: smallStackVerticalSpacing) {
                    titleStack(small: false)
                }
                .frame(height: controlStackSize)
            }
            
            AssetActionsView(viewModel: viewModel)
        }
    }
}

struct AssetTitleView_Previews: PreviewProvider {
    static var previews: some View {
        AssetTitleView(
            viewModel: .init(
                asset: Asset(
                    coin: Coin(
                        code: "BTC",
                        name: "Bitcoin",
                        icon: UIImage(imageLiteralResourceName: "iconBtc")
                    )
                )
            ),
            smallSize: false
        )
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .background(Color.portalBackground.edgesIgnoringSafeArea(.all))
    }
}
