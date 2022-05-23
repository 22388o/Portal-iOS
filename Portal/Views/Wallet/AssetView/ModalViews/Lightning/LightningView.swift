//
//  LightningView.swift
//  Portal
//
//  Created by Farid on 11.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI
import Combine

struct LightningView: View {
    
    @ObservedObject var viewModel: ChannelsViewModel
    @State private var createInvoice: Bool = false
    @State private var payInvoice: Bool = false
    @State var manageChannels: Bool = false
    
    
    var body: some View {
        print(Self._printChanges())
        
        return ZStack(alignment: .top) {
            Color.portalBackground.edgesIgnoringSafeArea(.all)
            
            
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
                            manageChannels.toggle()
                        }
                }
                .padding()
                .sheet(isPresented: $manageChannels) {
                    ManageChannelsView(viewModel: viewModel)
                }
                
                VStack {
                    HStack {
                        Text("On-chain")
                            .font(.mainFont(size: 14))
                            .foregroundColor(Color.lightInactiveLabel)
                        
                        Spacer()
                        
                        Text(viewModel.btcAdapter.balance.string + " BTC")
                            .font(.mainFont(size: 14))
                            .foregroundColor(Color.lightActiveLabel)
                    }
                    
                    HStack {
                        Text("Lightning")
                            .font(.mainFont(size: 14))
                            .foregroundColor(Color.lightInactiveLabel)
                        
                        Spacer()
                        
                        Text("\(viewModel.channelBalance) sat")
                            .font(.mainFont(size: 14))
                            .foregroundColor(Color.lightActiveLabel)
                    }
                    
                    HStack {
                        Button("Receive") {
                            createInvoice.toggle()
                        }
                        .modifier(PButtonEnabledStyle(enabled: .constant(true)))
                        Button("Send") {
                            payInvoice.toggle()
                        }
                        .modifier(PButtonEnabledStyle(enabled: .constant(true)))
                    }
                    .sheet(isPresented: $createInvoice) {
                        CreateInvoiceView(viewModel: viewModel)
                    }
                    .sheet(isPresented: $payInvoice) {
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
                
                if !viewModel.recentActivity.isEmpty {
                    ScrollView {
                        VStack(spacing: 0) {
                            ForEach(viewModel.recentActivity) { activity in
                                LightningActivityItemView(activity: activity)
                            }
                            .frame(height: 80)
                            .padding(.horizontal)
                            .padding(.vertical, 6)
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
        var invoice = "lntb14n1p3gh89zdq22dskgumpvsnp4qvl9aj3srrztegzcs7envyvn5jvxeselx2m6tmjwxjr5rr24hleekpp5dz4naqx6kq8llk7nz66whh8r9amx8vf4w5ww9h5we5jtgx4t3r4qsp5gvrzkatasv3hxhvtqxcqyvqkk3u6yykzex7gczu0vkhu5qf488ms9qyysgqcqpcrzjqv96c8tzk6pc547rq8t7qfz89xuknx5d4nlul00rtx4u9npqwqdr5g0m7cqqqqgqqqqqqqlgqqqqqqgq9qq7sxae0vg7dasgh0f8vwuvlpnmhp82sj9actyaxfgya04r7lnlc97yus4n022anwltfdqn45v7crpd735vk7wzx8se5pfj2vj4vlw3gpdp7fwx"
        
        let result = Invoice.from_str(s: invoice)
        if result.isOk() {
            let invoice = result.getValue()!
            
            let expired = invoice.is_expired()
            
            if expired {
                print("invoice is expired")
                return
            }
            
            let amount = invoice.amount_milli_satoshis().getValue()!
            print("amount \(amount) sat")
            
            let payee_pub_key = LDKBlock.bytesToHexString(bytes: invoice.payee_pub_key())
            print(payee_pub_key)
            
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
                .background(Color.black.opacity(0.25))
            
            VStack {
                HStack {
                    Text(activity.state.description)
                        .foregroundColor(Color.lightInactiveLabel)
                    
                    Spacer()
                    Text("\(activity.satAmount) sat")
                        .foregroundColor(Color.white)
                    
                }
                
                HStack {
                    Text("\(activity.date.timeAgoSinceDate(shortFormat: false))")
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
        LightningView(viewModel: .init())
    }
}
#endif
