//
//  AssetActionsView.swift
//  Portal
//
//  Created by Farid on 13.07.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct AssetActionsView: View {
    private let controlStackButtonsSpacing: CGFloat = 8
    private let buttonsSideOffset: CGFloat = -10
    
    @ObservedObject private var viewModel: AssetViewModel
    
    init(viewModel: AssetViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: controlStackButtonsSpacing) {
            HStack {
                Spacer()
                Button("Send") {
                    self.viewModel.showSendView.toggle()
                }
                .modifier(PButtonEnabledStyle(enabled: .constant(true)))
                .sheet(isPresented: $viewModel.showSendView) {
                    SendCoinView(asset: self.viewModel.asset)
                }
                Spacer()
                Button("Receive") {
                    self.viewModel.showReceiveView.toggle()
                }
                .modifier(PButtonEnabledStyle(enabled: .constant(true)))
                .sheet(isPresented: $viewModel.showReceiveView) {
                    ReceiveCoinView(asset: self.viewModel.asset)
                }
                Spacer()
            }
            
            HStack {
                Spacer()
                Button("Send to exchange") {
                    self.viewModel.showSendToExchangeView.toggle()
                }
                .modifier(PButtonEnabledStyle(enabled: .constant(true)))
                .sheet(isPresented: $viewModel.showSendToExchangeView) {
                    SendToExchangeView(asset: self.viewModel.asset)
                }
                Spacer()
            }
            
            HStack {
                Spacer()
                Button("Withdraw") {
                    self.viewModel.showWithdrawView.toggle()
                }
                .modifier(PButtonEnabledStyle(enabled: .constant(true)))
                .sheet(isPresented: $viewModel.showWithdrawView) {
                    WithdrawCoinView()
                }
                Spacer()
            }
            
        }
        .padding([.leading, .trailing], buttonsSideOffset)
    }
}

#if DEBUG
struct AssetActionsView_Previews: PreviewProvider {
    static var previews: some View {
        AssetActionsView(
            viewModel: .init(
                asset: Asset(
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
