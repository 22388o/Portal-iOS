//
//  MarketChangeProvider.swift
//  Portal
//
//  Created by Farid on 19.05.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import Foundation

final class MarketChangeProvider: IMarketChangeProvider {
    let tempChange: String = "+\(Double.random(in: 1.25..<8.95).rounded(toPlaces: 2))%"
    var changeString: String {
        tempChange
    }
}
