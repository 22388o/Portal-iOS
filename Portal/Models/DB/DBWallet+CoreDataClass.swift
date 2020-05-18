//
//  DBWallet+CoreDataClass.swift
//  
//
//  Created by Farid on 14.05.2020.
//
//

import Foundation
import CoreData

@objc(DBWallet)
public class DBWallet: NSManagedObject, IWallet {
    var walletID: UUID {
        id
    }
    
    var assets: [IAsset] = []
        
    var key: String {
        "\(self.id.uuidString)-\(self.name)-seed"
    }
    
    convenience init(model: NewWalletModel, context: NSManagedObjectContext) {
        self.init(context: context)
        self.id = model.id
        self.name = model.name
        self.fiatCurrencyCode = "USD"
        
        context.insert(self)
        
        do {
            try context.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func setup(data: Data) {
        assets = [
            BTC(marketData: CoinMarketData()),
            BCH(marketData: CoinMarketData()),
            ETH(marketData: CoinMarketData())
        ]
    }
}
