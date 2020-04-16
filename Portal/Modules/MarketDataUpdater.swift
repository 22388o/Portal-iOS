//
//  MarketDataUpdater.swift
//  Portal
//
//  Created by Farid on 16.04.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import Foundation
import Combine

final class HistoricalDataUpdater: HistoricalData {
    var onUpdatePublisher = PassthroughSubject<HistoricalDataResponse, Never>()
    
    private let marketDataQueue = DispatchQueue(label: "com.portal.market.data.queue", attributes: .concurrent)
    private let jsonDecoder: JSONDecoder
    private var task: URLSessionTask?
    
    init(jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.jsonDecoder = jsonDecoder
    }
    
    func fetchHistoricalData(assets: String, _ competionHandler: @escaping ((Result<HistoricalDataResponse, NetworkError>) -> Void)) {
//        guard let url = URL(string: "https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC&tsyms=USD,EUR") else {
//            competionHandler(.failure(.networkError))
//            return
//        }
//        task = URLSession.shared.dataTask(with: url) { data, response, error in
//            switch (data, error) {
//            case (_, .some):
//                competionHandler(.failure(.networkError))
//            case let (.some(data), nil):
//                guard let mockResponse = fullPriceResponse.data(using: .utf8) else {
//                    return
//                }
//                guard let response = try? self.jsonDecoder.decode(HistoricalDataResponse.self, from: mockResponse) else {
//                    competionHandler(.failure(.parsing))
//                    return
//                }
//                competionHandler(.success(response))
//            case (nil, nil):
//                competionHandler(.failure(.inconsistentBehavior))
//            }
//        }
    }
}
