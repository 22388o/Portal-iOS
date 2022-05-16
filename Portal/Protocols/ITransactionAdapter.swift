//
//  ITransactionAdapter.swift
//  Portal
//
//  Created by Farid on 13.07.2021.
//

import Foundation
import Combine
import BitcoinCore

protocol ITransactionsAdapter {
    var coin: Coin { get }
    var transactionState: AdapterState { get }
    var lastBlockInfo: LastBlockInfo? { get }
    var transactionStateUpdated: AnyPublisher<Void, Never> { get }
    var lastBlockUpdated: AnyPublisher<BlockInfo, Never> { get }
    var transactionRecords: AnyPublisher<[TransactionRecord], Never> { get }
    func transactions(from: TransactionRecord?, limit: Int) -> Future<[TransactionRecord], Never>
    func rawTransaction(hash: String) -> String?
}
