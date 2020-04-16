//
//  RatesDataUpdater.swift
//  Portal
//
//  Created by Farid on 14.04.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

typealias Rates = [String : Double]

struct FiatRatesResponse: Codable {
    let success: Bool
    let rates: Rates?
}

final class RatesDataUpdater: ObservableObject {
    let onUpdatePublisher = PassthroughSubject<Rates, Never>()
    
    private var task: URLSessionTask?
    
    private let jsonDecoder: JSONDecoder
    private let timer: DispatchSourceTimer
        
    init(
        jsonDecoder: JSONDecoder = JSONDecoder(),
        timer: DispatchSourceTimer = DispatchSource.makeTimerSource(queue: .global(qos: .userInitiated)),
        interval: Int
    ) {
        self.jsonDecoder = jsonDecoder

        self.timer = timer
        self.timer.schedule(deadline: .now(), repeating: .seconds(interval))
        self.timer.setEventHandler { [weak self] in
            guard self?.task?.state != .running else { return }
            
            self?.updateRates { [weak self] result in
                guard let self = self else { return }
                switch result {
                case let .success(rates):
                    self.onUpdatePublisher.send(rates)
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }

        }
        self.timer.resume()
    }
    
    deinit {
        timer.setEventHandler(handler: nil)
        timer.cancel()
        // https://forums.developer.apple.com/thread/15902
        timer.resume()
    }
            
    private func updateRates(_ competionHandler: @escaping ((Result<Rates, NetworkError>) -> Void)) {
        guard let url = URL(string: "https://data.fixer.io/api/latest?access_key=13af1e52c56117b6c7d513603fb7cee8&base=USD") else {
            competionHandler(.failure(.networkError))
            return
        }
        task = URLSession.shared.dataTask(with: url) { data, response, error in
            switch (data, error) {
            case (_, .some):
                competionHandler(.failure(.networkError))
            case let (.some(data), nil):
                guard let response = try? self.jsonDecoder.decode(FiatRatesResponse.self, from: data) else {
                    competionHandler(.failure(.parsing))
                    return
                }
                guard response.success else {
                    competionHandler(.failure(.networkError))
                    return
                }
                guard let rates = response.rates else {
                    competionHandler(.failure(.inconsistentBehavior))
                    return
                }
                competionHandler(.success(rates))
            case (nil, nil):
                competionHandler(.failure(.inconsistentBehavior))
            }
        }
        task?.resume()
    }
}
