//
//  AccountRecord+CoreDataClass.swift
//  Portal
//
//  Created by farid on 5/2/22.
//  Copyright © 2022 Tides Network. All rights reserved.
//
//

import Foundation
import CoreData

@objc(AccountRecord)
public class AccountRecord: NSManagedObject {
    var fiatCurrencyCode: String { fiatCurrency }
    
    var bip: MnemonicDerivation {
        MnemonicDerivation.bip84
    }
    
    convenience init(id: String, name: String, bip: MnemonicDerivation, context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.id = id
        self.name = name
        
        self.btcNetwork = 1 //testNet
        self.btcBipFormat = Int16(bip.intValue)
        
        self.ethNetwork = 1 //ropsten
        self.confirmationThreshold = 0
        
        self.coins = ["BTC", "ETH"]
    }
    
    func updateFiatCurrency(_ currency: FiatCurrency) {
        guard let contex = self.managedObjectContext else { return }
        fiatCurrency = currency.code
        try? contex.save()
    }
}
