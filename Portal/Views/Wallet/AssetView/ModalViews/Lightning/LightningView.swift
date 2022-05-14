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
                        
                        Text("0.00021 BTC")
                            .font(.mainFont(size: 14))
                            .foregroundColor(Color.lightActiveLabel)
                    }
                    
                    HStack {
                        Button("Receive") {
                            createInvoice.toggle()
                        }
                        .modifier(PButtonEnabledStyle(enabled: .constant(true)))
                        Button("Send") {
                            
                        }
                        .modifier(PButtonEnabledStyle(enabled: .constant(true)))
                    }
                    .sheet(isPresented: $createInvoice) {
                        CreateInvoiceView(viewModel: viewModel)
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
