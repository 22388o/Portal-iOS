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
                    Spacer()
                        .frame(height: 8)
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
                    
                    Spacer().frame(height: 8)
                    
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
                            .padding([.trailing, .leading], 8)
                            .padding([.top, .bottom], 4)
                            .background(Color.assetViewButton)
                            .cornerRadius(12)
                            .font(Font.mainFont(size: 12))
                            .foregroundColor(.white)
                    }
                    
                    Spacer().frame(height: 16)
                    
                    ExchangerView(viewModel: self.viewModel.exchangerViewModel)
                    
                    Spacer().frame(height: 16)
                    
                    VStack(alignment: .leading) {
                        Text("Send to...")
                            .font(Font.mainFont())
                            .foregroundColor(Color.white)
                        
                        Spacer().frame(height: 16)
                        
                        VStack {
                            TextField("", text: self.$viewModel.receiverAddress)
                                .modifier(
                                    PlaceholderStyle(
                                        showPlaceHolder: self.viewModel.receiverAddress.isEmpty,
                                        placeholder: "Enter \(self.viewModel.asset.coin.code) address..."
                                    )
                                )
                                .frame(height: 20)
                                .font(Font.mainFont(size: 16))
                        }
                        .modifier(TextFieldModifier())
                        
//                        Picker("TxFee", selection: self.$viewModel.selctionIndex) {
//                            ForEach(0 ..< BtcAddressFormat.allCases.count) { index in
//                                Text(BtcAddressFormat.allCases[index].description).tag(index)
//                            }
//                        }
//                        .pickerStyle(SegmentedPickerStyle())
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
 
