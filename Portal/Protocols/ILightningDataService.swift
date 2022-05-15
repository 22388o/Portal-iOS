//
//  ILightningDataService.swift
//  Portal
//
//  Created by farid on 5/16/22.
//  Copyright © 2022 Tides Network. All rights reserved.
//

import Foundation

protocol ILightningDataService {
    var nodes: [LightningNode] { get }
    var channels: [LightningChannel] { get }
    var payments: [LightningPayment] { get }
    func save(channel: LightningChannel)
    func save(payment: LightningPayment)
    func update(node: LightningNode)
    func update(channel: LightningChannel)
    func update(payment: LightningPayment)
}
