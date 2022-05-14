//
//  LightningPayment.swift
//  Portal
//
//  Created by farid on 5/12/22.
//  Copyright © 2022 Tides Network. All rights reserved.
//

import Foundation

class LightningPayment: Identifiable {
    enum State: Int16 {
        case requested = 0, sent, recieved
        
        var description: String {
            switch self {
            case .requested:
                return "Requested payment"
            case .sent:
                return "Sent"
            case .recieved:
                return "Received"
            }
        }
    }
    let id: String
    let satAmount: UInt64
    let date: Date
    let memo: String
    var state: State
    
    init(id: String, satAmount: Int64, date: Date, memo: String, state: State) {
        self.id = id
        self.satAmount = UInt64(satAmount)
        self.date = date
        self.memo = memo
        self.state = state
    }
    
    init(record: DBLightningPayment) {
        self.id = record.paymentID
        self.satAmount = UInt64(record.satValue)
        self.date = record.date
        self.memo = record.memo
        self.state = State(rawValue: record.state)!
    }
}

