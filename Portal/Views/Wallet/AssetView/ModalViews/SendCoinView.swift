//
//  SendCoinView.swift
//  Portal
//
//  Created by Farid on 11.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI

struct SendCoinView: View {
    @ObservedObject var viewModel: SendCoinViewModel
    
    init(asset: IAsset) {
        self.viewModel = .init(asset: asset)
    }
    
    private func endEditing() {
        UIApplication.shared.windows.first?.endEditing(true)
    }
    
    var body: some View {
        ZStack {
            Color.portalBackground.edgesIgnoringSafeArea(.all)
            
            Background {
                VStack {
                    VStack {
                        Image(uiImage: self.viewModel.asset.coin.icon)
                            .resizable()
                            .frame(width: 60, height: 60)
                        Text("Send \(self.viewModel.asset.coin.name)")
                            .font(Font.mainFont(size: 23))
                            .foregroundColor(Color.white)
                        Text("Instantly send to any \(self.viewModel.asset.coin.code) address")
                            .font(Font.mainFont())
                            .foregroundColor(Color.white)
                            .opacity(0.6)
                    }
                                        
                    HStack {
                        Text("You have")
                            .font(Font.mainFont())
                            .foregroundColor(Color.white)
                            .opacity(0.6)
                        
                        Text("\(self.viewModel.asset.balanceProvider.balanceString) \(self.viewModel.asset.coin.code)")
                            .font(Font.mainFont(size: 14))
                            .foregroundColor(Color.white)
                        
                        Button("send all") {
                            self.viewModel.sendAll()
                        }
                            .modifier(SmallButtonModifier())
                    }
                    
                    Spacer().frame(height: 15)
                    
                    ExchangerView(viewModel: self.viewModel.exchangerViewModel)
                    
                    Spacer().frame(height: 20)
                    
                    VStack(spacing: 20) {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Send to...")
                                .font(Font.mainFont())
                                .foregroundColor(Color.white)
                                                    
                            HStack() {
                                Text(self.viewModel.receiverAddress.isEmpty ? "Address" : self.viewModel.receiverAddress)
                                    .font(Font.mainFont(size: 16))
                                    .foregroundColor(self.viewModel.receiverAddress.isEmpty ? Color.lightActiveLabelNew : Color.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Button("Scan") {
                                    self.viewModel.sendAll()
                                }
                                    .modifier(SmallButtonModifier())
                                Button("Paste") {
                                    self.viewModel.sendAll()
                                }
                                    .modifier(SmallButtonModifier())
                            }
                            .modifier(TextFieldModifier())
                        }

                                            
                        VStack(spacing: 18) {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Transaction fee")
                                        .font(Font.mainFont())
                                        .foregroundColor(Color.white)
                                    Spacer()
                                    Text(self.viewModel.txFee)
                                        .font(Font.mainFont())
                                        .foregroundColor(Color.white)
                                }
                                Picker("TxFee", selection: self.$viewModel.selctionIndex) {
                                    ForEach(0 ..< 3) { index in
                                        Text(TxSpeed.allCases[index].title).tag(index)
                                    }
                                }.pickerStyle(SegmentedPickerStyle())
                            }
                            
                            VStack {
                                Text(TxSpeed.allCases[self.viewModel.selctionIndex].description)
                                    .font(Font.mainFont())
                                    .foregroundColor(Color.white)
                                    .opacity(0.6)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Button("Send") {
                        print("SEND")
                    }
                    .modifier(PButtonEnabledStyle(enabled: self.$viewModel.formIsValid))
                    .disabled(!self.viewModel.formIsValid)
                }
            }.onTapGesture {
                self.endEditing()
            }
            .keyboardResponsive()
        }
    }
}

#if DEBUG
struct SendCoinsView_Previews: PreviewProvider {
    static var previews: some View {
        SendCoinView(
            asset: Asset(
                coin: Coin(
                    code: "ETH",
                    name: "Ethereum",
                    color: UIColor.yellow,
                    icon: UIImage(imageLiteralResourceName: "iconEth")
                )
            )
        )
    }
}
#endif
 
