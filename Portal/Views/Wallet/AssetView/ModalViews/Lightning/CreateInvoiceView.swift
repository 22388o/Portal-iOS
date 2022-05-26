//
//  CreateInvoiceView.swift
//  Portal
//
//  Created by farid on 5/12/22.
//  Copyright © 2022 Tides Network. All rights reserved.
//

import SwiftUI

class CreateInvoiceViewModel: ObservableObject {
    @ObservedObject var exchangerViewModel: ExchangerViewModel = .init(asset: Coin.bitcoin(), fiat: USD)
    @Published var memo: String = ""
    @Published var qrCode: UIImage?
    @Published var invoiceString = String()
    @Published var showShareSheet: Bool = false
    @Published var fiatValue = String()
    
    private var btcAdapter = PolarConnectionExperiment.shared.bitcoinAdapter
    
    init() {
        
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
    
    func createInvoice() {
        if let invoice = PolarConnectionExperiment.shared.service.createInvoice(amount: exchangerViewModel.assetValue, memo: memo) {
            invoiceString = invoice
            qrCode = qrCode(address: invoice)
        }
    }
}

struct CreateInvoiceView: View {
    @StateObject var vm = CreateInvoiceViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.portalBackground.edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Create invoice")
                    .font(.mainFont(size: 18))
                    .foregroundColor(Color.white)
                    .padding()
                
                if let code = vm.qrCode {
                    Image(uiImage: code)
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width - 80, height: UIScreen.main.bounds.width - 80)
                        .cornerRadius(10)
                    
                    Text("Invoice:")
                        .font(.mainFont(size: 14))
                        .foregroundColor(Color.lightInactiveLabel)
                    
                    Text("\(vm.invoiceString)")
                        .font(.mainFont(size: 14))
                        .foregroundColor(Color.white)
                        .padding()
                    
                    Spacer()
                    
                    Button("Share") {
                        vm.showShareSheet.toggle()
                    }
                    .modifier(PButtonEnabledStyle(enabled: .constant(true)))
                    .padding()
                    .sheet(isPresented: $vm.showShareSheet) {
                        ShareSheet(activityItems: [vm.invoiceString])
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
                                TextField("", text: $vm.exchangerViewModel.assetValue)
                                    .modifier(
                                        PlaceholderStyle(
                                            showPlaceHolder: vm.exchangerViewModel.assetValue.isEmpty,
                                            placeholder: "0"
                                        )
                                    )
                                    .frame(height: 20)
                                    .keyboardType(.numberPad)
                                
                                Text("sat")
                                    .foregroundColor(Color.lightActiveLabelNew)//.opacity(0.4)
                            }
                            .modifier(TextFieldModifier())
                            .font(Font.mainFont(size: 16))
                        }
                        
                        HStack(spacing: 2) {
                            Spacer()
                            Text(vm.fiatValue)
                                .font(Font.mainFont())
                                .foregroundColor(Color.lightActiveLabelNew)
                                .keyboardType(.numberPad)
                            if !vm.exchangerViewModel.fiatValue.isEmpty {
                                Text("USD")
                                    .font(Font.mainFont())
                                    .foregroundColor(Color.lightActiveLabelNew)
                            }
                        }
                        .padding(.horizontal)
                        
                        Text("Description")
                            .font(Font.mainFont())
                            .foregroundColor(Color.white)
                        
                        TextField("", text: $vm.memo)
                            .modifier(
                                PlaceholderStyle(
                                    showPlaceHolder: vm.memo.isEmpty,
                                    placeholder: "Description..."
                                )
                            )
                            .frame(height: 20)
                            .modifier(TextFieldModifier())
                        
//                        HStack {
//                            Text("Expires:")
//                                .font(Font.mainFont())
//                                .foregroundColor(Color.white)
//
//                            Text("\(expireDate)")
//                                .lineLimit(1)
//                                .font(Font.mainFont())
//                                .foregroundColor(Color.lightActiveLabelNew)
//                        }
//                        .padding(.vertical)
                        
//                        DatePicker("Expire date", selection: $expireDate, in: limitRange, displayedComponents: [.date, .hourAndMinute])
//                            .font(Font.mainFont())
//                            .foregroundColor(Color.white)
//                            .datePickerStyle(WheelDatePickerStyle())
                    }
                    .padding()
                    
                    Spacer()
                    
                    Button("Create") {
                        vm.createInvoice()
                    }
                    .modifier(PButtonEnabledStyle(enabled: .constant(true)))
                    .padding()
                }
            }
            .padding()
            .onReceive(vm.exchangerViewModel.$fiatValue, perform: { value in
                vm.fiatValue = value
            })
        }
    }
}
