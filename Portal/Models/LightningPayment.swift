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
    let created: Date
    var expires: Date?
    let memo: String
    var state: State
    var invoice: String?
    
    var isExpired: Bool {
        guard let expireDate = expires else {
            return false
        }
        return Date() > expireDate
    }
    
    init(invoice: Invoice, memo: String) {
        self.id = UUID().uuidString
        self.satAmount = invoice.amount_milli_satoshis().getValue()!/1000
        self.created = Date()
        let expiteTime = TimeInterval(invoice.expiry_time())
        self.expires = Date(timeIntervalSince1970: expiteTime)
        self.state = .requested
        self.invoice = invoice.to_str()
        self.memo = memo
    }
    
    init(id: String, satAmount: Int64, created: Date, memo: String, state: State) {
        self.id = id
        self.satAmount = UInt64(satAmount)
        self.created = created
        self.memo = memo
        self.state = state
    }
    
    init(record: DBLightningPayment) {
        self.id = record.paymentID
        self.satAmount = UInt64(record.satValue)
        self.created = record.created
        self.expires = record.expires
        self.memo = record.memo
        self.state = State(rawValue: record.state)!
        self.invoice = record.invoice
    }
}

