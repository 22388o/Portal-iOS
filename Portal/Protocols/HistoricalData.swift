//
//  HistoricalData.swift
//  Portal
//
//  Created by Farid on 16.04.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import Foundation
import Combine

typealias HistoricalDataResponse = Dictionary<String, [MarketSnapshot]>

protocol HistoricalData: ObservableObject {
    var onUpdatePublisher: PassthroughSubject<HistoricalDataResponse, Never> { get }
    func fetchHistoricalData(assets: String, _ competionHandler: @escaping ((Result<HistoricalDataResponse, NetworkError>) -> Void))
}
