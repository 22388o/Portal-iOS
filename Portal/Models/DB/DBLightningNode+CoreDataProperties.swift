//
//  DBLightningNode+CoreDataProperties.swift
//  Portal
//
//  Created by farid on 5/11/22.
//  Copyright © 2022 Tides Network. All rights reserved.
//
//

import Foundation
import CoreData


extension DBLightningNode {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBLightningNode> {
        return NSFetchRequest<DBLightningNode>(entityName: "DBLightningNode")
    }

    @NSManaged public var alias: String
    @NSManaged public var host: String
    @NSManaged public var port: Int16
    @NSManaged public var publicKey: String
    @NSManaged public var channels: NSOrderedSet

}

// MARK: Generated accessors for channels
extension DBLightningNode {

    @objc(insertObject:inChannelsAtIndex:)
    @NSManaged public func insertIntoChannels(_ value: DBLightningChannel, at idx: Int)

    @objc(removeObjectFromChannelsAtIndex:)
    @NSManaged public func removeFromChannels(at idx: Int)

    @objc(insertChannels:atIndexes:)
    @NSManaged public func insertIntoChannels(_ values: [DBLightningChannel], at indexes: NSIndexSet)

    @objc(removeChannelsAtIndexes:)
    @NSManaged public func removeFromChannels(at indexes: NSIndexSet)

    @objc(replaceObjectInChannelsAtIndex:withObject:)
    @NSManaged public func replaceChannels(at idx: Int, with value: DBLightningChannel)

    @objc(replaceChannelsAtIndexes:withChannels:)
    @NSManaged public func replaceChannels(at indexes: NSIndexSet, with values: [DBLightningChannel])

    @objc(addChannelsObject:)
    @NSManaged public func addToChannels(_ value: DBLightningChannel)

    @objc(removeChannelsObject:)
    @NSManaged public func removeFromChannels(_ value: DBLightningChannel)

    @objc(addChannels:)
    @NSManaged public func addToChannels(_ values: NSOrderedSet)

    @objc(removeChannels:)
    @NSManaged public func removeFromChannels(_ values: NSOrderedSet)

}

extension DBLightningNode : Identifiable {

}
