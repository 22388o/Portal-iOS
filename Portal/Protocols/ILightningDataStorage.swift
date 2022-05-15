//
//  ILightningDataStorage.swift
//  Portal
//
//  Created by farid on 5/16/22.
//  Copyright © 2022 Tides Network. All rights reserved.
//

import Foundation

protocol ILightningDataStorage {
    func fetchNodes() throws -> [LightningNode]
    func fetchChannels() throws -> [LightningChannel]
    func fetchPayments() throws -> [LightningPayment]
    func save(nodes: [LightningNode]) throws
    func save(channel: LightningChannel) throws
    func save(payment: LightningPayment) throws
    func update(node: LightningNode) throws
    func update(channel: LightningChannel) throws
    func update(payment: LightningPayment) throws
}
