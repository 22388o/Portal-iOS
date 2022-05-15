//
//  ILightningSerivice.swift
//  Portal
//
//  Created by farid on 5/16/22.
//  Copyright © 2022 Tides Network. All rights reserved.
//

import Foundation

protocol ILightningService {
    var dataService: ILightningDataService { get }
    var manager: ILightningChannelManager { get }
    
    func connect(node: LightningNode)
    func disconnect(node: LightningNode)
    func openChannelWith(node: LightningNode, sat: Int)
    func createInvoice(amount: String, memo: String) -> String?
}
