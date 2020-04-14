//
//  Enums.swift
//  Portal
//
//  Created by Farid on 09.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import Foundation

enum UserCurrency: Int {
    case usd
    case btc
    case eth
    
    func stringValue() -> String {
        switch self {
        case .usd: return "USD"
        case .btc: return "BTC"
        case .eth: return "ETH"
        }
    }
}

enum Timeframe: Int {
    case hour = 0, day, week, month, year, allTime
    
    func intervalString() -> String {
        switch self {
        case .hour:
            return "1h"
        case .day:
            return "1d"
        case .week:
            return "1w"
        case .month:
            return "1M"
        default:
            return ""
        }
    }
    
    func toString() -> String {
        let intervalString: String!
        switch self {
        case .hour:
            intervalString = "Hour"
        case .day:
            intervalString = "Day"
        case .week:
            intervalString = "Week"
        case .month:
            intervalString = "Month"
        case .year:
            intervalString = "Year"
        default:
            intervalString = ""
        }
        return intervalString + " change"
    }
}
