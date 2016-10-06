//
//  Tags+CoreDataProperties.swift
//  hackerbookv2
//
//  Created by Antonio Benavente del Moral on 6/10/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import Foundation
import CoreData


extension Tags {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tags> {
        return NSFetchRequest<Tags>(entityName: "Tags");
    }

    @NSManaged public var orderTag: String?
    @NSManaged public var tag: String?
    @NSManaged public var booktag: NSSet?

}

// MARK: Generated accessors for booktag
extension Tags {

    @objc(addBooktagObject:)
    @NSManaged public func addToBooktag(_ value: BookTag)

    @objc(removeBooktagObject:)
    @NSManaged public func removeFromBooktag(_ value: BookTag)

    @objc(addBooktag:)
    @NSManaged public func addToBooktag(_ values: NSSet)

    @objc(removeBooktag:)
    @NSManaged public func removeFromBooktag(_ values: NSSet)

}
