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
        let btc = Coin(code: "BTC", name: "Bitcoin", color: UIColor.green, icon: UIImage(imageLiteralResourceName: "iconBtc"))
        let bch = Coin(code: "BCH", name: "Bitcoin Cash", color: UIColor.gray, icon: UIImage(imageLiteralResourceName: "iconBch"))
        let eth = Coin(code: "ETH", name: "Ethereum", color: UIColor.yellow, icon: UIImage(imageLiteralResourceName: "iconEth"))
        let xlm = Coin(code: "XLM", name: "Stellar Lumens", color: UIColor.blue, icon: UIImage(imageLiteralResourceName: "iconXlm"))
        let xtz = Coin(code: "XTZ", name: "Stellar Lumens", color: UIColor.brown, icon: UIImage(imageLiteralResourceName: "iconXtz"))
        
        let erz = Coin(code: "ERZ", name: "Eeeeee Rrrrr Z", color: UIColor.yellow, icon: UIImage(imageLiteralResourceName: "iconEth"))
        let mfk = Coin(code: "MFK", name: "EEEEEE fffff KK", color: UIColor.blue, icon: UIImage(imageLiteralResourceName: "iconXlm"))
        let ped = Coin(code: "PED", name: "PPPPPPeeeeee D", color: UIColor.brown, icon: UIImage(imageLiteralResourceName: "iconXtz"))
        
        let las = Coin(code: "LAS", name: "LaaaaaaSSSSS", color: UIColor.yellow, icon: UIImage(imageLiteralResourceName: "iconEth"))
        let ndc = Coin(code: "NDC", name: "Nnnnnnn DDDDD CCC", color: UIColor.blue, icon: UIImage(imageLiteralResourceName: "iconXlm"))
        let ncb = Coin(code: "NCB", name: "NNNNNNNcccccdssdf", color: UIColor.brown, icon: UIImage(imageLiteralResourceName: "iconXtz"))
        
        self.assets = [
            Asset(coin: btc, data: data),
            Asset(coin: bch, data: data),
            Asset(coin: eth, data: data),
            
            Asset(coin: xlm, data: data),
            Asset(coin: xtz, data: data),
            
            Asset(coin: erz, data: data),
            Asset(coin: mfk, data: data),
            Asset(coin: ped, data: data),
            
            Asset(coin: las, data: data),
            Asset(coin: ndc, data: data),
            Asset(coin: ncb, data: data),
            
            Asset(coin: xlm, data: data),
            Asset(coin: xtz, data: data),
            
            Asset(coin: erz, data: data),
            Asset(coin: mfk, data: data),
            Asset(coin: ped, data: data),
            
            Asset(coin: las, data: data),
            Asset(coin: ndc, data: data),
            Asset(coin: ncb, data: data),
            
            Asset(coin: xlm, data: data),
            Asset(coin: xtz, data: data)
            
//            Asset(coin: erz, data: data),
//            Asset(coin: mfk, data: data),
//            Asset(coin: ped, data: data),
//
//            Asset(coin: las, data: data),
//            Asset(coin: ndc, data: data),
//            Asset(coin: ncb, data: data),
//
//            Asset(coin: xlm, data: data),
//            Asset(coin: xtz, data: data),
//
//            Asset(coin: erz, data: data),
//            Asset(coin: mfk, data: data),
//            Asset(coin: ped, data: data),
//
//            Asset(coin: las, data: data),
//            Asset(coin: ndc, data: data),
//            Asset(coin: ncb, data: data)
        ]
    }
}
