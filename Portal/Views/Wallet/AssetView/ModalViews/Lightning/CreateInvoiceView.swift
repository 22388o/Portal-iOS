//
//  CreateInvoiceView.swift
//  Portal
//
//  Created by farid on 5/12/22.
//  Copyright © 2022 Tides Network. All rights reserved.
//

import SwiftUI

struct CreateInvoiceView: View {
    @ObservedObject var viewModel: ChannelsViewModel
    @ObservedObject var exchangerViewModel: ExchangerViewModel = .init(asset: Coin.bitcoin(), fiat: USD)
    private var btcAdapter = PolarConnectionExperiment.shared.bitcoinAdapter
    @State private var memo: String = ""
    @State private var qrCode: UIImage?
    @State private var invoiceString = String()
    @State private var showShareSheet: Bool = false
    
    init(viewModel: ChannelsViewModel) {
        self.viewModel = viewModel
    }
    
    func qrCode(address: String?) -> UIImage {
        guard let message = address?.data(using: .utf8) else { return UIImage() }
        
        let parameters: [String : Any] = [
                    "inputMessage": message,
                    "inputCorrectionLevel": "L"
                ]
        let filter = CIFilter(name: "CIQRCodeGenerator", parameters: parameters)
        
        guard let outputImage = filter?.outputImage else { return UIImage() }
               
        let scaledImage = outputImage.transformed(by: CGAffineTransform(scaleX: 6, y: 6))
        guard let cgImage = CIContext().createCGImage(scaledImage, from: scaledImage.extent) else {
            return UIImage()
        }
        
        return UIImage(cgImage: cgImage)
    }

    var body: some View {
        ZStack(alignment: .top) {
            Color.portalBackground.edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Create invoice")
                    .font(.mainFont(size: 18))
                    .foregroundColor(Color.white)
                    .padding()
                
                if let code = qrCode {
                    Image(uiImage: code)
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width - 80, height: UIScreen.main.bounds.width - 80)
                        .cornerRadius(10)
                        
                    Text("Invoice:")
                        .font(.mainFont(size: 14))
                        .foregroundColor(Color.lightInactiveLabel)
                    
                    Text("\(invoiceString)")
                        .font(.mainFont(size: 14))
                        .foregroundColor(Color.white)
                        .padding()
                    
                    Spacer()
                    
                    Button("Share") {
                        showShareSheet.toggle()
                    }
                    .modifier(PButtonEnabledStyle(enabled: .constant(true)))
                    .padding()
                    .sheet(isPresented: $showShareSheet) {
                        ShareSheet(activityItems: [invoiceString])
                    }
                } else {
                    VStack(alignment: .leading) {
                        Text("Amount")
                            .font(Font.mainFont())
                            .foregroundColor(Color.white)
                        
                        VStack(spacing: 4) {
                            HStack(spacing: 8) {
                                Image(uiImage: UIImage(imageLiteralResourceName: "iconBtc"))
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                TextField("", text: $exchangerViewModel.assetValue)
                                    .modifier(
                                        PlaceholderStyle(
                                            showPlaceHolder: exchangerViewModel.assetValue.isEmpty,
                                            placeholder: "0.0"
                                        )
                                    )
                                    .frame(height: 20)
                                    .keyboardType(.numberPad)
                                Text(exchangerViewModel.asset.code)
                                    .foregroundColor(Color.lightActiveLabelNew)//.opacity(0.4)
                            }
                                .modifier(TextFieldModifier())
                            
                            Text("=").foregroundColor(Color.white)
                            
                            HStack(spacing: 8) {
                                FiatCurrencyView(
                                    size: 24,
                                    currencySymbol: .constant(exchangerViewModel.fiat.symbol),
                                    state: .constant(.fiat),
                                    currency: .constant(.fiat(USD))
                                )
                                    .frame(width: 24, height: 24)
                                
                                TextField("", text: $exchangerViewModel.fiatValue)
                                    .modifier(
                                        PlaceholderStyle(
                                            showPlaceHolder: exchangerViewModel.fiatValue.isEmpty,
                                            placeholder: "0.0"
                                        )
                                    )
                                    .frame(height: 20)
                                    .keyboardType(.numberPad)
                                
                                Text(exchangerViewModel.fiat.code).foregroundColor(Color.lightActiveLabelNew)
                            }
                                .modifier(TextFieldModifier())
                        }
                            .font(Font.mainFont(size: 16))
                    }
                        .padding()
                    
                    TextField("", text: $memo)
                        .modifier(
                            PlaceholderStyle(
                                showPlaceHolder: memo.isEmpty,
                                placeholder: "Description..."
                            )
                        )
                        .frame(height: 20)
                        .modifier(TextFieldModifier())
                        .padding()
                    
                    Spacer()
                    
                    Button("Create") {
                        if let invoice = viewModel.createInvoice(amount: exchangerViewModel.assetValue, memo: memo) {
                            invoiceString = invoice
                            qrCode = qrCode(address: invoice)
                        }
                    }
                    .modifier(PButtonEnabledStyle(enabled: .constant(true)))
                    .padding()
                }
            }
            .padding()
            .onDisappear {
//                viewModel.recentActivity.insert(LightningActivityItem(id: UUID(), amount: "+ \(exchangerViewModel.assetValue) BTC", fiatAmount: "\(exchangerViewModel.fiatValue) USD", date: "04/06/22", status: "Requested payment", memo: memo), at: 0)
            }
        }
    }
}
