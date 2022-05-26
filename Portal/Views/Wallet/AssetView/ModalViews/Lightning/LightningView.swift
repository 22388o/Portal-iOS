//
//  LightningView.swift
//  Portal
//
//  Created by Farid on 11.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI
import Combine

class LightningViewViewModel: ObservableObject {
    @Published var createInvoice: Bool = false
    @Published var payInvoice: Bool = false
    @Published var manageChannels: Bool = false
    @Published var showActivityDetails: Bool = false
    @Published var payments: [LightningPayment] = []
    
    var btcAdapter = PolarConnectionExperiment.shared.bitcoinAdapter
    var channelManager = PolarConnectionExperiment.shared.service.manager.channelManager
    var selectedPayment: LightningPayment?
    
    var onChainBalanceString: String {
        btcAdapter.balance.string + " BTC"
    }
    
    var channelsBalanceString: String {
        var balaance: UInt64 = 0
        for channel in channelManager.list_usable_channels() {
            balaance+=channel.get_balance_msat()/1000
        }
        return "\(balaance) sat"
    }
    
    init() {
        
    }
    
    func refreshPayments() {
        payments = PolarConnectionExperiment.shared.service.dataService.payments.sorted(by: {$0.created > $1.created})
    }
}

struct LightningView: View {
    @StateObject var vm = LightningViewViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.portalBackground.edgesIgnoringSafeArea(.all)
                .onAppear {
                    vm.refreshPayments()
                }
            
            
            VStack {
                HStack {
                    Text("Channels")
                        .font(.mainFont(size: 18))
                        .foregroundColor(Color.white)
                    Spacer()
                    
                    Text("Manage")
                        .font(.mainFont(size: 14))
                        .foregroundColor(Color.lightActiveLabel)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            vm.manageChannels.toggle()
                        }
                }
                .padding()
                .sheet(isPresented: $vm.manageChannels) {
                    ManageChannelsView()
                }
                
                VStack {
                    HStack {
                        Text("On-chain")
                            .font(.mainFont(size: 14))
                            .foregroundColor(Color.lightInactiveLabel)
                        
                        Spacer()
                        
                        Text(vm.onChainBalanceString)
                            .font(.mainFont(size: 14))
                            .foregroundColor(Color.lightActiveLabel)
                    }
                    
                    HStack {
                        Text("Lightning")
                            .font(.mainFont(size: 14))
                            .foregroundColor(Color.lightInactiveLabel)
                        
                        Spacer()
                        
                        Text(vm.channelsBalanceString)
                            .font(.mainFont(size: 14))
                            .foregroundColor(Color.lightActiveLabel)
                    }
                    
                    HStack {
                        Button("Receive") {
                            vm.createInvoice.toggle()
                        }
                        .modifier(PButtonEnabledStyle(enabled: .constant(true)))
                        Button("Send") {
                            vm.payInvoice.toggle()
                        }
                        .modifier(PButtonEnabledStyle(enabled: .constant(true)))
                    }
                    .sheet(isPresented: $vm.createInvoice, onDismiss: {
                        vm.refreshPayments()
                    }, content: {
                        CreateInvoiceView()
                    })
                    .sheet(isPresented: $vm.payInvoice) {
                        vm.refreshPayments()
                    } content: {
                        PayInvoiceView()
                    }
                }
                .padding()
                
                HStack {
                    Text("Payments")
                        .font(.mainFont(size: 14))
                        .foregroundColor(Color.white)
                    Spacer()
                }
                .padding([.horizontal])
                
                Rectangle()
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                
                if !vm.payments.isEmpty {
                    ScrollView {
                        VStack(spacing: 0) {
                            ForEach(vm.payments) { payment in
                                LightningActivityItemView(activity: payment)
                                    .onTapGesture {
                                        guard payment.state == .requested else { return }
                                        vm.selectedPayment = payment
                                        vm.showActivityDetails.toggle()
                                    }
                            }
                            .frame(height: 80)
                            .padding(.horizontal)
                            .padding(.vertical, 6)
                            .sheet(isPresented: $vm.showActivityDetails) {
                                ActivityDetailsView(activity: vm.selectedPayment!)
                            }
                        }
                    }
                } else {
                    Spacer()
                    Text("There is no activity.")
                        .font(.mainFont(size: 14))
                        .foregroundColor(Color.lightActiveLabel)
                    Spacer()
                }
            }
        }
    }
}

struct ActivityDetailsView: View {
    let activity: LightningPayment
    @State var qrCode: UIImage?
    @State var showShareSheet: Bool = false
    
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
                Text("Invoice")
                    .font(.mainFont(size: 18))
                    .foregroundColor(Color.white)
                
                if let code = qrCode {
                    Image(uiImage: code)
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width - 80, height: UIScreen.main.bounds.width - 80)
                        .cornerRadius(10)
                        .padding()
                } else {
                    Spacer().frame(width: UIScreen.main.bounds.width - 80, height: UIScreen.main.bounds.width - 80)
                        .padding()
                }
                
                HStack {
                    Text("Amount:")
                        .font(.mainFont(size: 14))
                        .foregroundColor(Color.lightInactiveLabel)
                    
                    Spacer()
                    
                    Text("\(activity.satAmount) sat")
                        .font(.mainFont(size: 14))
                        .foregroundColor(Color.lightActiveLabel)
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Description:")
                        .font(.mainFont(size: 14))
                        .foregroundColor(Color.lightInactiveLabel)
                    
                    Spacer()
                    
                    Text("\(activity.memo)")
                        .font(.mainFont(size: 14))
                        .foregroundColor(Color.lightActiveLabel)
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Created:")
                        .font(.mainFont(size: 14))
                        .foregroundColor(Color.lightInactiveLabel)
                           
                    Spacer()
                    
                    Text("\(activity.created)")
                        .lineLimit(1)
                        .font(.mainFont(size: 14))
                        .foregroundColor(Color.lightActiveLabel)
                }
                .padding(.horizontal)
                
                if !activity.isExpired {
                    HStack {
                        Text("Expires:")
                            .font(.mainFont(size: 14))
                            .foregroundColor(Color.lightInactiveLabel)
                               
                        Spacer()
                        
                        Text("\(activity.expires!)")
                            .lineLimit(1)
                            .font(.mainFont(size: 14))
                            .foregroundColor(Color.lightActiveLabel)
                    }
                    .padding(.horizontal)
                } else {
                    HStack {
                        Text("Status:")
                            .font(.mainFont(size: 14))
                            .foregroundColor(Color.lightInactiveLabel)
                        
                        Spacer()
                        
                        Text("Expired")
                            .font(.mainFont(size: 14))
                            .foregroundColor(Color.lightActiveLabel)
                    }
                    .padding(.horizontal)
                }
                
                Text("Invoice:")
                    .font(.mainFont(size: 14))
                    .foregroundColor(Color.lightInactiveLabel)
                    .padding(.vertical)

                Text("\(activity.invoice!)")
                    .font(.mainFont(size: 12))
                    .foregroundColor(Color.white)
                    .padding(.horizontal)
                
                Spacer()
                
                Button("Share") {
                    showShareSheet.toggle()
                }
                .modifier(PButtonEnabledStyle(enabled: .constant(true)))
                .padding()
                .sheet(isPresented: $showShareSheet) {
                    ShareSheet(activityItems: [activity.invoice!])
                }
            }
            .padding()
            .onAppear {
                DispatchQueue.main.async {
                    qrCode = qrCode(address: activity.invoice!)
                }
            }
        }
    }
}

class PayInvoiceViewModel: ObservableObject {
    @Published var invoiceString = String()
    private var subscriptions = Set<AnyCancellable>()
    var invstr = "lntb23450p1p3g0yf0dqqnp4qvl9aj3srrztegzcs7envyvn5jvxeselx2m6tmjwxjr5rr24hleekpp5ewkhu0rqdwam5mqddg46r9f57zleqgk3zfntt0mr067v5erlp7xssp5ahgvry0fgvyaml8zmf2wfz0455pex85cd90vqfuljhhdn07pltvs9qyysgqcqpcgmnnu4z6zvxsx8w7mcj9ppv68wmnn8tex8d4ylfez4dunk8j3srxea5eeypddhc8urp30mudevesresmxncj6ejqrkdsjkls8cfl79gqkjja5m"
    
    var channelBalance: UInt64 {
        var balance: UInt64 = 0
        
        for channel in PolarConnectionExperiment.shared.service.manager.channelManager.list_usable_channels() {
            balance+=channel.get_balance_msat()/1000
        }
        
        return balance
    }
    
    init() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            self.paste()
//        }
    }
    
    
    
    func paste() {
        invoiceString = invstr
    }
    
    func send() {
        var invoice = "lntb13300n1p3ghj9app53re3dfzjygjww8u3xrvzm5c3a4uggl0cfzj0ruc894q82erllrsqdqqcqzpgxqyz5vqsp536yel9mu42pn9ahkywkjfnn9552svza32tcmx0emdhenwa476lvq9qyyssqqe0v5gt34fjzj2x97l83ye2egmws9zp3j7xgjmv4y4xdx0lf6pmhhhh42n5uutpk9nzkl8d6fyptaszknvu7z54c3gyzszuev96npkcp28xese"
        
        let result = Invoice.from_str(s: invoice)
        if result.isOk() {
            let invoice = result.getValue()!
            
            let expired = invoice.is_expired()
            
            if expired {
                print("invoice is expired")
                return
            }
            
            let amount = invoice.amount_milli_satoshis().getValue()!
            print("amount \(amount/1000) sat")
            
            let payee_pub_key = LDKBlock.bytesToHexString(bytes: invoice.payee_pub_key())
            print(payee_pub_key)
            
            let network = invoice.currency()
            print(network)
                                    
            let payer = PolarConnectionExperiment.shared.service.manager.payer!
            
            let payerResult = payer.pay_invoice(invoice: invoice)
            
            if payerResult.isOk() {
                print("invoice payed!")
            } else {
                if let error = payerResult.getError() {
                    switch error.getValueType() {
                    case .Invoice:
                        print("invoice error")
                        print("\(error.getValueAsInvoice()!)")
                        let error = error.getValueAsInvoice()!
                        PolarConnectionExperiment.shared.userMessage = "Invoice error: \(error)"
                    case .Routing:
                        print("routing error")
                        print("\(error.getValueAsRouting()!.get_err())")
                        let error = error.getValueAsRouting()!.get_err()
                        PolarConnectionExperiment.shared.userMessage = "Routing error: \(error)"
                    case .Sending:
                        print("sending error")
                        print("\(error.getValueAsSending()!)")
                        let error = error.getValueAsSending()!
                        PolarConnectionExperiment.shared.userMessage = "Sending error: \(error)"
                    case .none:
                        print("unknown error")
                    }
                }
            }
            
        } else {
            print("invoice parsing failed")
        }
    }
}

struct PayInvoiceView: View {
    @ObservedObject var viewModel = PayInvoiceViewModel()
    
    var body: some View {
        ZStack {
            Color.portalBackground.edgesIgnoringSafeArea(.all)
            
            Background {
                VStack {
                    VStack {
                        Image(uiImage: UIImage(imageLiteralResourceName: "iconBtc"))
                            .resizable()
                            .frame(width: 60, height: 60)
                        Text("Pay Invoice")
                            .font(Font.mainFont(size: 23))
                        Text("Instantly send over lightning network")
                            .font(Font.mainFont())
                            .opacity(0.6)
                    }
                        .foregroundColor(Color.white)
                                        
                    HStack {
                        Text("You have")
                            .font(Font.mainFont())
                            .opacity(0.6)
                        
                        Text("\(self.viewModel.channelBalance) sat")
                            .font(Font.mainFont(size: 14))
                    }
                        .foregroundColor(Color.white)
                    
                    Spacer().frame(height: 15)
                    
                    HStack(spacing: 8) {
                        Image(uiImage: UIImage(imageLiteralResourceName: "iconBtc"))
                            .resizable()
                            .frame(width: 24, height: 24)
                        TextField("", text: $viewModel.invoiceString)
                            .modifier(
                                PlaceholderStyle(
                                    showPlaceHolder: viewModel.invoiceString.isEmpty,
                                    placeholder: "Paste invoice here..."
                                )
                            )
                            .frame(height: 20)
                    }
                        .modifier(TextFieldModifier())
                    
                    Spacer().frame(height: 20)
                    
                    Spacer()
                    
                    Button("Send") {
                        print("SEND")
                        viewModel.send()
                    }
                    .modifier(PButtonEnabledStyle(enabled: .constant(true)))

//                    .alert(isPresented: self.$showingAlert) {
//                        Alert(
//                            title: Text("\(self.viewModel.exchangerViewModel.assetValue) \(self.viewModel.asset.coin.code) sent to"),
//                            message: Text("\(self.viewModel.receiverAddress)"),
//                            dismissButton: Alert.Button.default(
//                                Text("Dismiss"), action: { self.presentationMode.wrappedValue.dismiss() }
//                            )
//                        )
//                    }
//                    .modifier(PButtonEnabledStyle(enabled: !self.$viewModel.invoiceString.isEmpty))
//                    .disabled(!self.viewModel.formIsValid)
                }
            }.onTapGesture {

            }
        }
    }
}

struct LightningActivityItemView: View {
    let activity: LightningPayment
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(activity.isExpired ? Color.white.opacity(0.25) : Color.black.opacity(0.25))
            
            VStack {
                HStack {
                    Text(activity.state.description)
                        .foregroundColor(Color.lightInactiveLabel)
                    
                    Spacer()
                    Text("\(activity.satAmount) sat")
                        .foregroundColor(Color.white)
                    
                }
                
                HStack {
                    Text("\(activity.created.timeAgoSinceDate(shortFormat: false))")
                        .foregroundColor(Color.lightInactiveLabel)
                    
                    Spacer()
                    Text("fiat amount")
                        .foregroundColor(Color.lightActiveLabel)
                    
                }
                
                HStack {
                    Text("Description")
                        .foregroundColor(Color.lightInactiveLabel)
                    
                    Spacer()
                    Text(activity.memo)
                        .foregroundColor(Color.lightActiveLabel)
                    
                }
            }
            .font(.mainFont(size: 14))
            .padding(.horizontal)
        }
    }
}

#if DEBUG
struct WithdrawCoinView_Previews: PreviewProvider {
    static var previews: some View {
        LightningView()
    }
}
#endif
