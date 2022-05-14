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
    @Published var recentActivity = PolarConnectionExperiment.shared.lightningDataService.payments
    @Published var suggestedNodes = PolarConnectionExperiment.shared.lightningDataService.nodes
    @Published var openChannels = PolarConnectionExperiment.shared.lightningDataService.channels
    
    @Published var createNewChannel: Bool = false
    @Published var fundChannel: Bool = false
    @Published var channelIsOpened: Bool = false
    @Published var exchangerViewModel: ExchangerViewModel
    @Published var txFee = String()
    @Published var selctionIndex = 1
    @Published var showChannelDetails: Bool = false
    var selectedNode: LightningNode?
    
    var btcAdapter = PolarConnectionExperiment.shared.btcAdapter
    
    init() {
        exchangerViewModel = .init(asset: Coin.bitcoin(), fiat: USD)
    }
    
    func openAChannel(node: LightningNode) {
        if let decimalAmount = Decimal(string: exchangerViewModel.assetValue) {
            let satoshiAmount = btcAdapter.convertToSatoshi(value: decimalAmount)
            selectedNode = node
            PolarConnectionExperiment.shared.openChannelWith(node: node, sat: satoshiAmount)
        }
        channelIsOpened.toggle()
    }
    
    func createInvoice(amount: String, memo: String) -> String? {
        if let decimalAmount = Decimal(string: amount) {
            let satoshiAmount = btcAdapter.convertToSatoshi(value: decimalAmount)
            let amount = Option_u64Z(value: UInt64(satoshiAmount))
            let descr = memo
            let cm = PolarConnectionExperiment.shared.channelManager!
            let km = PolarConnectionExperiment.shared.keysManager
            let result = Bindings.swift_create_invoice_from_channelmanager(channelmanager: cm, keys_manager: km.as_KeysInterface(), network: LDKCurrency_BitcoinTestnet, amt_msat: amount, description: descr)
            
            if result.isOk(), let invoice = result.getValue() {
                let payment = LightningPayment(
                    id: UUID().uuidString,
                    satAmount: Int64(satoshiAmount),
                    date: Date(),
                    memo: memo,
                    state: .requested
                )
                PolarConnectionExperiment.shared.lightningDataService.save(payment: payment)
                
                return invoice.to_str()
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
}
