//
//  AssetItemView.swift
//  Portal
//
//  Created by Farid on 06.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct AssetItemView: View {
    @ObservedObject var viewModel: AssetItemViewModel
            
    init(viewModel: AssetItemViewModel) {
        self.viewModel = viewModel
    }
    
    private var emptyView: some View {
        HStack {
            EmptyView()
        }
            .frame(minWidth: 0, maxWidth: .infinity)
    }
    
    var body: some View {
        HStack(alignment: .center) {
            Image(uiImage: UIImage(imageLiteralResourceName: "iconBtc"))
                .resizable()
                .frame(width: 24, height: 24)
                .padding([.leading])
            
            VStack(spacing: 6) {
                HStack {
                    Text(viewModel.code)
                    emptyView
                    Text(viewModel.balance)
                }
                    .font(Font.mainFont(size: 18))
                    .foregroundColor(Color.white)
                
                HStack {
                    Text(viewModel.name)
                    emptyView
                    Text(viewModel.totalValue)
                }
                    .font(Font.mainFont(size: 14))
                    .foregroundColor(Color.white.opacity(0.6))

                
                HStack {
                    Text(viewModel.price)
                    emptyView
                    Text(viewModel.change)
                }
                    .font(Font.mainFont(size: 14))
                    .foregroundColor(Color.white.opacity(0.6))
            }
                .padding([.trailing, .top, .bottom], 15)
                .padding(.leading, 5)
        }
            .background(Color.black.opacity(0.25))
            .cornerRadius(16)
            .onAppear(perform: {
                print("\(self.viewModel.code) on Appear")
            })
            .onDisappear(perform: {
                print("\(self.viewModel.code) on Disappear")
            })
    }
}

#if DEBUG
struct AssetItemView_Previews: PreviewProvider {
    static var previews: some View {
        AssetItemView(viewModel:
            AssetItemViewModel(asset:
                Asset(
                    coin: Coin.bitcoin()
                )
            )
        )
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .background(Color.portalBackground.edgesIgnoringSafeArea(.all))
    }
}
#endif
