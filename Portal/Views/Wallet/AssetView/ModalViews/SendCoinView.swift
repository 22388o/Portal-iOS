//
//  SendCoinView.swift
//  Portal
//
//  Created by Farid on 11.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI
//import CodeScanner

struct SendCoinView: View {
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject private var viewModel: SendCoinViewModel
        
    private let textFiledForegroundColor = Color.white
    
    private let mainFont = Font.mainFont()
    private let titleFont = Font.mainFont(size: 23)
    private let totalAmountFont = Font.mainFont(size: 14)
    private let addressFont = Font.mainFont(size: 16)
    
    private let iconSize: CGFloat = 60
    private let bottomStackSpacing: CGFloat = 18
    private let horizontalSpacerHeight: CGFloat = 20
    private let subtitleFontOpacity: Double = 0.6
    
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
                            .frame(width: self.iconSize, height: self.iconSize)
                        Text("Send \(self.viewModel.asset.coin.name)")
                            .font(self.titleFont)
                        Text("Instantly send to any \(self.viewModel.asset.coin.code) address")
                            .font(self.mainFont)
                            .opacity(self.subtitleFontOpacity)
                    }
                        .foregroundColor(self.textFiledForegroundColor)
                                        
                    HStack {
                        Text("You have")
                            .font(self.mainFont)
                            .opacity(self.subtitleFontOpacity)
                        
                        Text("\(self.viewModel.asset.balanceProvider.balanceString) \(self.viewModel.asset.coin.code)")
                            .font(self.totalAmountFont)
                        
                        Button("send all") {
                            self.viewModel.sendAll()
                        }
                            .modifier(SmallButtonModifier())
                    }
                        .foregroundColor(self.textFiledForegroundColor)
                    
                    Spacer().frame(height: self.horizontalSpacerHeight)
                    
                    ExchangerView(viewModel: self.viewModel.exchangerViewModel)
                    
                    Spacer().frame(height: self.horizontalSpacerHeight)
                    
                    VStack(spacing: self.bottomStackSpacing) {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Send to...")
                                .font(self.mainFont)
                                .foregroundColor(self.textFiledForegroundColor)
                                                    
                            HStack {
                                Text(self.viewModel.receiverAddress.isEmpty ? "Address" : self.viewModel.receiverAddress)
                                    .font(self.addressFont)
                                    .foregroundColor(self.viewModel.receiverAddress.isEmpty ? Color.lightActiveLabelNew : self.textFiledForegroundColor)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Button("Scan") {
                                    self.viewModel.isShowingScanner.toggle()
                                }
                                    .modifier(SmallButtonModifier())
                                    .sheet(isPresented: self.$viewModel.isShowingScanner) {
                                        EmptyView()
//                                        CodeScannerView(codeTypes: [.qr], simulatedData: "1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2", completion: self.viewModel.handleScanResults)
                                    }
                                
                                Button("Paste") {
                                    self.viewModel.pasteFromClipboard()
                                }
                                    .modifier(SmallButtonModifier())
                            }
                            .modifier(TextFieldModifier())
                        }

                                            
                        VStack(spacing: self.bottomStackSpacing) {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Transaction fee")
                                    Spacer()
                                    Text(self.viewModel.txFee)
                                }
                                .font(self.mainFont)
                                .foregroundColor(self.textFiledForegroundColor)
                                
                                Picker("TxFee", selection: self.$viewModel.selctionIndex) {
                                    ForEach(0 ..< TxSpeed.allCases.count) { index in
                                        Text(TxSpeed.allCases[index].title).tag(index)
                                    }
                                }
                                    .pickerStyle(SegmentedPickerStyle())
                            }
                            
                            VStack {
                                Text(TxSpeed.allCases[self.viewModel.selctionIndex].description)
                                    .font(self.mainFont)
                                    .foregroundColor(self.textFiledForegroundColor)
                                    .opacity(self.subtitleFontOpacity)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Button("Send") {
                        print("SEND")
                        self.viewModel.showingAlert.toggle()
                    }
                    .alert(isPresented: self.$viewModel.showingAlert) {
                        Alert(
                            title: Text("\(self.viewModel.exchangerViewModel.assetValue) \(self.viewModel.asset.coin.code) sent to"),
                            message: Text("\(self.viewModel.receiverAddress)"),
                            dismissButton: Alert.Button.default(
                                Text("Dismiss"), action: { self.presentationMode.wrappedValue.dismiss() }
                            )
                        )
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
        Group {
            SendCoinView(
                asset: Asset(
                    coin: Coin(
                        code: "BTC",
                        name: "Bitcoin",
                        color: UIColor.yellow,
                        icon: UIImage(imageLiteralResourceName: "iconBtc")
                    )
                )
            )
            .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
            .previewDisplayName("iPhone SE")
            
            
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
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
            .previewDisplayName("iPhone 11 Pro")
            
            SendCoinView(
                asset: Asset(
                    coin: Coin(
                        code: "XTZ",
                        name: "Stellar Lumens",
                        color: UIColor.yellow,
                        icon: UIImage(imageLiteralResourceName: "iconXtz")
                    )
                )
            )
            .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
            .previewDisplayName("iPhone 11")
            
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
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
            .previewDisplayName("iPhone 11 Pro Max")
            
        }
    }
}
#endif
 
