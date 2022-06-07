//
//  DBLightningChannelManager+CoreDataProperties.swift
//  Portal
//
//  Created by farid on 5/19/22.
//  Copyright © 2022 Tides Network. All rights reserved.
//
//

import Foundation
import CoreData


extension DBLightningChannelManager {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBLightningChannelManager> {
        return NSFetchRequest<DBLightningChannelManager>(entityName: "DBLightningChannelManager")
    }

    @NSManaged public var data: Data?

}

extension DBLightningChannelManager : Identifiable {

}
