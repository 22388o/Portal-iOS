//
//  DBWallet+CoreDataClass.swift
//  
//
//  Created by Farid on 14.05.2020.
//
//

import Foundation
import CoreData
import SwiftUI

@objc(DBWallet)
public class DBWallet: NSManagedObject, IWallet {
    var walletID: UUID {
        id
    }
    
    var assets: [IAsset] = []
        
    var key: String {
        "\(id.uuidString)-\(name)-seed"
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
            fatalError(error)
        }
    }
    
    func setup(data: Data) {
        let sampleCoins = [
            Coin.bitcoin()
//            Coin.ethereum(),
//            Coin.portal()
        ]
        
        self.assets = sampleCoins.prefix(5).map{ Asset(coin: $0, data: data) }
        
//        for _ in 0...295 {
//            let randomIndex = Int.random(in: 5...sampleCoins.count - 1)
//            let coin = sampleCoins[randomIndex]
//            let asset = Asset(coin: coin, data: data)
//            assets.append(asset)
//        }
    }
}
