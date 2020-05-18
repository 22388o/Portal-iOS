//
//  Enums.swift
//  Portal
//
//  Created by Farid on 09.03.2020.
//  Copyright © 2020 Tides Network. All rights reserved.
//

import Foundation

enum BtcAddressFormat: Int, CustomStringConvertible, CaseIterable {
    case legacy
    case segwit
    case nativeSegwit
    
    var description: String {
        get {
            switch self {
            case .legacy:
                return "Legacy"
            case .segwit:
                return "SegWit"
            case .nativeSegwit:
                return "Native SegWit"
            }
        }
    }
}

enum MarketDataRange {
    case hour, day, week, month, year
}

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

import LocalAuthentication

enum Device {

    //To check that device has secure enclave or not
    public static var hasSecureEnclave: Bool {
        return !isSimulator && hasBiometrics
    }

    //To Check that this is this simulator
    public static var isSimulator: Bool {
        return TARGET_OS_SIMULATOR == 1
    }

    //Check that this device has Biometrics features available
    private static var hasBiometrics: Bool {

        //Local Authentication Context
        let localAuthContext = LAContext()
        var error: NSError?

        /// Policies can have certain requirements which, when not satisfied, would always cause
        /// the policy evaluation to fail - e.g. a passcode set, a fingerprint
        /// enrolled with Touch ID or a face set up with Face ID. This method allows easy checking
        /// for such conditions.
        var isValidPolicy = localAuthContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)

        guard isValidPolicy == true else {

            if #available(iOS 11, *) {

                if error!.code != LAError.biometryNotAvailable.rawValue {
                    isValidPolicy = true
                } else{
                    isValidPolicy = false
                }
            }
            else {
                if error!.code != LAError.touchIDNotAvailable.rawValue {
                    isValidPolicy = true
                }else{
                    isValidPolicy = false
                }
            }
            return isValidPolicy
        }
        return isValidPolicy
    }

}
