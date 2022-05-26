//
//  DBLightningPayment+CoreDataProperties.swift
//  Portal
//
//  Created by farid on 5/11/22.
//  Copyright © 2022 Tides Network. All rights reserved.
//
//

import Foundation
import CoreData


extension DBLightningPayment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBLightningPayment> {
        return NSFetchRequest<DBLightningPayment>(entityName: "DBLightningPayment")
    }

    @NSManaged public var paymentID: String
    @NSManaged public var satValue: Int64
    @NSManaged public var memo: String
    @NSManaged public var created: Date
    @NSManaged public var expires: Date?
    @NSManaged public var state: Int16
    @NSManaged public var invoice: String?

}

extension DBLightningPayment : Identifiable {

}
