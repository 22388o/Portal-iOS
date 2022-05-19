//
//  DBLightningNetGraph+CoreDataProperties.swift
//  Portal
//
//  Created by farid on 5/19/22.
//  Copyright © 2022 Tides Network. All rights reserved.
//
//

import Foundation
import CoreData


extension DBLightningNetGraph {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBLightningNetGraph> {
        return NSFetchRequest<DBLightningNetGraph>(entityName: "DBLightningNetGraph")
    }

    @NSManaged public var data: Data?

}

extension DBLightningNetGraph : Identifiable {

}
