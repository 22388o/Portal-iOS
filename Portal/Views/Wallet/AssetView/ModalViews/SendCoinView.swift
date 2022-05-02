//
//  SendCoinView.swift
//  Portal
//
//  Created by Farid on 11.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI
import CodeScanner

struct SendCoinView: View {
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var viewModel: SendCoinViewModel
    
    @State private var showingAlert = false
    
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
                        Image(uiImage: UIImage(imageLiteralResourceName: "iconBtc"))
                            .resizable()
                            .frame(width: 60, height: 60)
                        Text("Send \(self.viewModel.asset.coin.name)")
                            .font(Font.mainFont(size: 23))
                        Text("Instantly send to any \(self.viewModel.asset.coin.code) address")
                            .font(Font.mainFont())
                            .opacity(0.6)
                    }
                        .foregroundColor(Color.white)
                                        
                    HStack {
                        Text("You have")
                            .font(Font.mainFont())
                            .opacity(0.6)
                        
                        Text("\(self.viewModel.asset.balanceProvider.balanceString) \(self.viewModel.asset.coin.code)")
                            .font(Font.mainFont(size: 14))
                        
                        Button("send all") {
                            self.viewModel.sendAll()
                        }
                            .modifier(SmallButtonModifier())
                    }
                        .foregroundColor(Color.white)
                    
                    Spacer().frame(height: 15)
                    
                    ExchangerView(viewModel: self.viewModel.exchangerViewModel)
                    
                    Spacer().frame(height: 20)
                    
                    VStack(spacing: 20) {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Send to...")
                                .font(Font.mainFont())
                                .foregroundColor(Color.white)
                                                    
                            HStack {
                                Text(self.viewModel.receiverAddress.isEmpty ? "Address" : self.viewModel.receiverAddress)
                                    .font(Font.mainFont(size: 16))
                                    .foregroundColor(self.viewModel.receiverAddress.isEmpty ? Color.lightActiveLabelNew : Color.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Button("Scan") {
                                    self.viewModel.isShowingScanner.toggle()
                                }
                                .modifier(SmallButtonModifier())
                                .sheet(isPresented: self.$viewModel.isShowingScanner) {
                                    CodeScannerView(codeTypes: [.qr], simulatedData: "1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2", completion: self.viewModel.handleScanResults)
                                }
                                Button("Paste") {
                                    self.viewModel.pasteFromClipboard()
                                }
                                    .modifier(SmallButtonModifier())
                            }
                            .modifier(TextFieldModifier())
                        }

                                            
                        VStack(spacing: 18) {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Transaction fee")
                                    Spacer()
                                    Text(self.viewModel.txFee)
                                }
                                    .font(Font.mainFont())
                                    .foregroundColor(Color.white)
                                
                                Picker("TxFee", selection: self.$viewModel.selctionIndex) {
                                    ForEach(0 ..< 3) { index in
                                        Text(TxSpeed.allCases[index].title).tag(index)
                                    }
                                }
                                    .pickerStyle(SegmentedPickerStyle())
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
                        self.showingAlert.toggle()
                    }
                    .alert(isPresented: self.$showingAlert) {
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
                    coin: Coin.bitcoin()
                )
            )
            .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
            .previewDisplayName("iPhone SE")
            
            
            SendCoinView(
                asset: Asset(
                    coin: Coin.ethereum()
                )
            )
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
            .previewDisplayName("iPhone 11 Pro")
            
            SendCoinView(
                asset: Asset(
                    coin: Coin.bitcoin()
                )
            )
            .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
            .previewDisplayName("iPhone 11")
            
            SendCoinView(
                asset: Asset(
                    coin: Coin.ethereum()
                )
            )
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
            .previewDisplayName("iPhone 11 Pro Max")
            
        }
    }
}
#endif
 
