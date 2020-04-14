//
//  WalletItemViewModel.swift
//  Portal
//
//  Created by Farid on 06.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import Foundation
import SwiftUI

protocol WalletItemViewModel {
    var name: String { get }
    var symbol: String { get }
    var amount: String { get }
    var totalValue: String { get }
    var price: String { get }
    var change: String { get }
    var color: UIColor { get }
    var icon: UIImage { get }
    
    func value(currency: UserCurrency) -> Double
}

extension WalletItemViewModel {
    var icon: UIImage { UIImage() }
    var name: String { "Name" }
    var symbol: String { "Symbol" }
    var amount: String { "Amount" }
    var totalValue: String { "Total Value" }
    var price: String { "Price" }
    var change: String { "Change" }
    var color: UIColor { UIColor.clear }
    func QRCode(address: String? = btcMockAddress) -> UIImage {
        guard let message = address?.data(using: .utf8) else { return UIImage() }
        
        let parameters: [String : Any] = [
            "inputMessage": message,
            "inputCorrectionLevel": "L"
        ]
        let filter = CIFilter(name: "CIQRCodeGenerator", parameters: parameters)
        
        guard let outputImage = filter?.outputImage else {
            return UIImage()
        }
        
        let scaledImage = outputImage.transformed(by: CGAffineTransform(scaleX: 6, y: 6))
        guard let cgImage = CIContext().createCGImage(scaledImage, from: scaledImage.extent) else {
            return UIImage()
        }
                        
        return UIImage(cgImage: cgImage)
    }
    func value(currency: UserCurrency) -> Double {
        Double(totalValue) ?? 0.0
        //balance * marketData.price(currency: currency)
    }
    func values(timeframe: Timeframe, points: [MarketSnapshot]) -> [Double] {
//        let maxIndex = points.count
//        let calendar = Calendar.current
//        let currentDate = currentDateInUserTimeZone()
        switch timeframe {
        case .hour:
            return points.enumerated().map{ (index, point) in
//                let timestamp = calendar.date(byAdding: .minute, value: index - maxIndex, to: currentDate)?.timeIntervalSince1970
                return point.close //* balance(at: timestamp)
            }
        case .day, .week:
            return points.enumerated().map{ (index, point) in
//                let timestamp = calendar.date(byAdding: .hour, value: index - maxIndex, to: currentDate)?.timeIntervalSince1970
                return point.close //* balance(at: timestamp)
            }
        case .month, .year:
            return points.enumerated().map{ (index, point) in
//                let timestamp = calendar.date(byAdding: .day, value: index - maxIndex, to: currentDate)?.timeIntervalSince1970
                return point.close //* balance(at: timestamp)
            }
        case .allTime:
//            let timestamp = Date().timeIntervalSince1970
            return points.enumerated().map{ (index, point) in point.close /* balance(at: timestamp)*/ }
        }
    }
    
//    func currentDateInUserTimeZone() -> Date {
//        let currentDate = Date()
//
//        // 1) Get the current TimeZone's seconds from GMT. Since I am in Chicago this will be: 60*60*5 (18000)
//        let timezoneOffset =  TimeZone.current.secondsFromGMT()
//
//        // 2) Get the current date (GMT) in seconds since 1970. Epoch datetime.
//        let epochDate = currentDate.timeIntervalSince1970
//
//        // 3) Perform a calculation with timezoneOffset + epochDate to get the total seconds for the
//        //    local date since 1970.
//        //    This may look a bit strange, but since timezoneOffset is given as -18000.0, adding epochDate and timezoneOffset
//        //    calculates correctly.
//        let timezoneEpochOffset = (epochDate + Double(timezoneOffset))
//
//        // 4) Finally, create a date using the seconds offset since 1970 for the local date.
//        let timeZoneOffsetDate = Date(timeIntervalSince1970: timezoneEpochOffset)
//
//        return timeZoneOffsetDate
//    }
}
