//
//  WithdrawCoinView.swift
//  Portal
//
//  Created by Farid on 11.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import SwiftUI
import Combine

struct LightningNode: Identifiable {
    let id: UUID = UUID()
    let alias: String
    let publicKey: String
    let host: String
    let port: String
}

class ChannelsViewModel: ObservableObject {
    @Published var suggestedNodes: [LightningNode] = [
        LightningNode(
            alias: "ali/sand/pre",
            publicKey: "02202007c9fded3b8c042cc1c2583abd3c248f0f6d596eb899a6096bf537a0ede2",
            host: "35.224.10.41",
            port: "9735"
        ),
        LightningNode(
            alias: "HotBit's LND",
            publicKey: "023ac04112507e939eebb8dba569cbc33761516325adb435206a22d5bea11c1678",
            host: "47.254.43.49",
            port: "9735"
        ),
        LightningNode(
            alias: "SANDBOX_LN_Oracle_Network",
            publicKey: "02013e9b82ba5076e5abf67971e13a4d6a13c1aad18e8bdb3a431c4d137246c101",
            host: "217.173.236.67",
            port: "29735"
        )
    ]
    
    @Published var createNewChannel: Bool = false
    @Published var fundChannel: Bool = false
    @Published var channelIsOpened: Bool = false
    @ObservedObject var exchangerViewModel: ExchangerViewModel
    
    init() {
        exchangerViewModel = .init(asset: Coin.bitcoin(), fiat: USD)
    }
}

struct CreateNewChannelView: View {
    @ObservedObject var viewModel: ChannelsViewModel
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.portalBackground.edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Open a channel")
                    .font(.mainFont(size: 18))
                    .foregroundColor(Color.white)
                    .padding()
                
                if viewModel.fundChannel {
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .background(Color.black.opacity(0.25))
                            
                            VStack {
                                HStack {
                                    Text("Alias:")
                                        .foregroundColor(Color.lightInactiveLabel)

                                    Spacer()
                                    Text(viewModel.suggestedNodes[1].alias)
                                        .foregroundColor(Color.white)

                                }
                                HStack {
                                    Text("PubKey:")
                                        .foregroundColor(Color.lightInactiveLabel)

                                    Spacer()
                                    
                                    Text(viewModel.suggestedNodes[1].publicKey)
                                        .foregroundColor(Color.lightActiveLabel)
                                        .multilineTextAlignment(.trailing)

                                }
                                HStack {
                                    Text("Host:")
                                        .foregroundColor(Color.lightInactiveLabel)

                                    Spacer()
                                    Text(viewModel.suggestedNodes[1].host)
                                        .foregroundColor(Color.lightActiveLabel)

                                }
                                HStack {
                                    Text("Port:")
                                        .foregroundColor(Color.lightInactiveLabel)

                                    Spacer()
                                    Text(viewModel.suggestedNodes[1].port)
                                        .foregroundColor(Color.lightActiveLabel)

                                }
                            }
                            .font(.mainFont(size: 14))
                            .padding()
                        }
                        .frame(height: 120)
                        .padding(.horizontal)
                        
                        ExchangerView(viewModel: viewModel.exchangerViewModel)
                            .padding()
                        
                        Text("Set ammount of BTC you'd like to commit to the channel")
                            .font(.mainFont(size: 14))
                            .foregroundColor(Color.lightInactiveLabel)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        
                        Spacer()
                        
                        Button("Open") {
                            viewModel.channelIsOpened.toggle()
                            PolarConnectionExperiment.shared.openChannelWithAlice()
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        .modifier(PButtonEnabledStyle(enabled: .constant(true)))
                        .padding()
                    }
                } else {
                    Text("Open channels to other nodes on the network to start using Lightning Network.")
                        .font(.mainFont(size: 14))
                        .foregroundColor(Color.lightInactiveLabel)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    VStack(alignment: .leading) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 4)
                                .frame(height: 40)
                            
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 16, weight: .regular))
                                Text("Search the network")
                                    .foregroundColor(.white)
                                    .font(.mainFont(size: 14))
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        
                        Text("    Search for nodes by name, public key, or paste their pubkey@host")
                            .foregroundColor(Color.lightInactiveLabel)
                            .font(.mainFont(size: 10))
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Text("Suggested nodes")
                            .font(.mainFont(size: 14))
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top, 6)
                    
                    Rectangle()
                        .frame(height: 1)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                    
                    ScrollView {
                        VStack {
                            ForEach(viewModel.suggestedNodes) { node in
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .background(Color.black.opacity(0.25))
                                    
                                    VStack {
                                        HStack {
                                            Text("Alias:")
                                                .foregroundColor(Color.lightInactiveLabel)

                                            Spacer()
                                            Text(node.alias)
                                                .foregroundColor(Color.white)

                                        }
                                        HStack {
                                            Text("PubKey:")
                                                .foregroundColor(Color.lightInactiveLabel)

                                            Spacer()
                                            
                                            Text(node.publicKey)
                                                .foregroundColor(Color.lightActiveLabel)
                                                .multilineTextAlignment(.trailing)

                                        }
                                        HStack {
                                            Text("Host:")
                                                .foregroundColor(Color.lightInactiveLabel)

                                            Spacer()
                                            Text(node.host)
                                                .foregroundColor(Color.lightActiveLabel)

                                        }
                                        HStack {
                                            Text("Port:")
                                                .foregroundColor(Color.lightInactiveLabel)

                                            Spacer()
                                            Text(node.port)
                                                .foregroundColor(Color.lightActiveLabel)

                                        }
                                    }
                                    .font(.mainFont(size: 14))
                                    .padding()
                                }
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    PolarConnectionExperiment.shared.connectToAlice()
                                    viewModel.fundChannel.toggle()
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct WithdrawCoinView: View {
    
    @ObservedObject var viewModel: ChannelsViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.portalBackground.edgesIgnoringSafeArea(.all)
            
            
            VStack {
                
                Text("Channels")
                    .font(.mainFont(size: 18))
                    .foregroundColor(Color.white)
                    .padding()
                
                VStack {
                    HStack {
                        Text("On-chain")
                            .font(.mainFont(size: 14))
                            .foregroundColor(Color.lightInactiveLabel)
                        
                        Spacer()
                        
                        Text("1.15 BTC")
                            .font(.mainFont(size: 14))
                            .foregroundColor(Color.lightActiveLabel)
                    }
                    
                    HStack {
                        Text("Lightning")
                            .font(.mainFont(size: 14))
                            .foregroundColor(Color.lightInactiveLabel)
                        
                        Spacer()
                        
                        Text("0 BTC")
                            .font(.mainFont(size: 14))
                            .foregroundColor(Color.lightActiveLabel)
                    }
                }
                .padding()
                
                HStack {
                    Text("Open channels")
                        .font(.mainFont(size: 14))
                        .foregroundColor(Color.white)
                    Spacer()
                    
                    Button {
                        viewModel.createNewChannel.toggle()
                    } label: {
                        Image(systemName: "plus.viewfinder")
                            .foregroundColor(Color.lightInactiveLabel)
                            .font(.system(size: 16, weight: .regular))
                    }
                    .sheet(isPresented: $viewModel.createNewChannel) {
                        CreateNewChannelView(viewModel: viewModel)
                    }

                }
                .padding(.horizontal)
                
                Rectangle()
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                
                if viewModel.channelIsOpened {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .background(Color.black.opacity(0.25))
                        
                        VStack {
                            HStack {
                                Text("Alias:")
                                    .foregroundColor(Color.lightInactiveLabel)

                                Spacer()
                                Text(viewModel.suggestedNodes[1].alias)
                                    .foregroundColor(Color.white)

                            }
                        
                            HStack {
                                Text("Status:")
                                    .foregroundColor(Color.lightInactiveLabel)

                                Spacer()
                                Text("Waiting channel to be funded")
                                    .foregroundColor(Color.lightActiveLabel)

                            }
                        }
                        .font(.mainFont(size: 14))
                        .padding()
                    }
                    .frame(height: 60)
                    .padding()
                } else {
                    Spacer()
                    
                    Text("No channels. Create a new one")
                        .font(.mainFont(size: 14))
                        .foregroundColor(Color.lightInactiveLabel)
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

#if DEBUG
struct WithdrawCoinView_Previews: PreviewProvider {
    static var previews: some View {
        WithdrawCoinView(viewModel: .init())
    }
}
#endif
