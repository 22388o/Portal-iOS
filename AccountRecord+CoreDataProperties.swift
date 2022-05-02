//
//  AccountRecord+CoreDataProperties.swift
//  Portal
//
//  Created by farid on 5/2/22.
//  Copyright © 2022 Tides Network. All rights reserved.
//
//

import Foundation
import CoreData


extension AccountRecord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AccountRecord> {
        return NSFetchRequest<AccountRecord>(entityName: "AccountRecord")
    }
    
    @NSManaged public var btcNetwork: Int16
    @NSManaged public var btcBipFormat: Int16
    @NSManaged public var ethNetwork: Int16
    @NSManaged public var confirmationThreshold: Int16
    @NSManaged public var fiatCurrency: String
    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var coins: [String]
}
