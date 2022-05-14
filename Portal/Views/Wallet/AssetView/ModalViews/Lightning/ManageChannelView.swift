//
//  ManageChannelView.swift
//  Portal
//
//  Created by farid on 5/12/22.
//  Copyright © 2022 Tides Network. All rights reserved.
//

import SwiftUI

struct ManageChannelsView: View {
    @ObservedObject var viewModel: ChannelsViewModel
    @State var channelIsOpened: Bool = false
    @State var openNewChannel: Bool = false
    
    init(viewModel: ChannelsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.portalBackground.edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack {
                    HStack {
                        Text("Channels")
                            .font(.mainFont(size: 18))
                            .foregroundColor(Color.white)
                    }
                    .padding()
                    
                    HStack {
                        Text("Open channels")
                            .font(.mainFont(size: 14))
                            .foregroundColor(Color.white)
                        Spacer()
                        
                        Button {
                            openNewChannel.toggle()
                        } label: {
                            Image(systemName: "plus.viewfinder")
                                .foregroundColor(Color.accentColor)
                                .font(.system(size: 16, weight: .regular))
                        }
                        
                    }
                    .padding([.horizontal])
                    .sheet(isPresented: $openNewChannel) {
                        CreateNewChannelView(viewModel: viewModel)
                    }
                    
                    
                    Rectangle()
                        .frame(height: 1)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .padding([.horizontal, .bottom])
                    
                    if !viewModel.openChannels.isEmpty {
                        ScrollView {
                            VStack(spacing: 0) {
                                ForEach(viewModel.openChannels) { channel in
                                    ChannelItemView(channel: channel)
                                }
                            }
                        }
                    } else {
                        Spacer()
                        Text("There is no open channels yet.")
                            .font(.mainFont(size: 14))
                            .foregroundColor(Color.lightActiveLabel)
                        Spacer()
                    }
                }
            }
            .padding()
        }
    }
}

struct ChannelItemView: View {
    let channel: LightningChannel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .background(Color.black.opacity(0.25))
            
            VStack {
                HStack {
                    Text("Alias:")
                        .foregroundColor(Color.lightInactiveLabel)
                    
                    Spacer()
                    Text(channel.nodeAlias)
                        .foregroundColor(Color.white)
                    
                }
                
                HStack {
                    Text("Status:")
                        .foregroundColor(Color.lightInactiveLabel)
                    
                    Spacer()
                    
                    HStack(spacing: 8) {
                        Text(channel.state.description)
                            .foregroundColor(Color.lightActiveLabel)
                        
                        if channel.state == .waitingFunds {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                        }
                    }
                    
                }
                
                HStack {
                    Text("Balance:")
                        .foregroundColor(Color.lightInactiveLabel)
                    
                    Spacer()
                    Text("\(channel.satValue) sat")
                        .foregroundColor(Color.lightActiveLabel)
                    
                }
                
                if channel.state == .open {
                    Button {
                        
                    } label: {
                        Text("Close")
                    }
                }
            }
            .font(.mainFont(size: 14))
            .padding()
        }
        .frame(height: 80)
        .padding(.horizontal)
        .padding(.vertical, 6)
    }
}
