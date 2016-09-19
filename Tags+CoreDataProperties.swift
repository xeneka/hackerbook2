//
//  Tags+CoreDataProperties.swift
//  hackerbookv2
//
//  Created by Antonio Benavente del Moral on 19/9/16.
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
    @NSManaged public var books: NSSet?

}

// MARK: Generated accessors for books
extension Tags {

    @objc(addBooksObject:)
    @NSManaged public func addToBooks(_ value: Books)

    @objc(removeBooksObject:)
    @NSManaged public func removeFromBooks(_ value: Books)

    @objc(addBooks:)
    @NSManaged public func addToBooks(_ values: NSSet)

    @objc(removeBooks:)
    @NSManaged public func removeFromBooks(_ values: NSSet)

}
