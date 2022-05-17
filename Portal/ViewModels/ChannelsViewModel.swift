//
//  ChannelsViewModel.swift
//  Portal
//
//  Created by farid on 5/12/22.
//  Copyright © 2022 Tides Network. All rights reserved.
//

import Foundation
import Combine

class ChannelsViewModel: ObservableObject {
    @Published var recentActivity = PolarConnectionExperiment.shared.service.dataService.payments
    @Published var suggestedNodes = PolarConnectionExperiment.shared.service.dataService.nodes
    @Published var openChannels = PolarConnectionExperiment.shared.service.dataService.channels
    
    @Published var createNewChannel: Bool = false
    @Published var fundChannel: Bool = false
    @Published var channelIsOpened: Bool = false
    @Published var exchangerViewModel: ExchangerViewModel
    @Published var txFee = String()
    @Published var selctionIndex = 1
    @Published var showChannelDetails: Bool = false
    var selectedNode: LightningNode?
    
    var btcAdapter = PolarConnectionExperiment.shared.bitcoinAdapter
    
    init() {
        exchangerViewModel = .init(asset: Coin.bitcoin(), fiat: USD)
    }
    
    func openAChannel(node: LightningNode) {
        if let decimalAmount = Decimal(string: exchangerViewModel.assetValue) {
            let satoshiAmount = btcAdapter.convertToSatoshi(value: decimalAmount)
            selectedNode = node
            PolarConnectionExperiment.shared.service.openChannelWith(node: node, sat: satoshiAmount)
            channelIsOpened.toggle()
        }
    }
    
    func createInvoice(amount: String, memo: String) -> String? {
        if let invoice = PolarConnectionExperiment.shared.service.createInvoice(amount: amount, memo: memo) {
            return nil
        } else {
            return nil
        }
    }
}
