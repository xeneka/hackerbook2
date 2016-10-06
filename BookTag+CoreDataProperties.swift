//
//  BookTag+CoreDataProperties.swift
//  hackerbookv2
//
//  Created by Antonio Benavente del Moral on 6/10/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import Foundation
import CoreData


extension BookTag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookTag> {
        return NSFetchRequest<BookTag>(entityName: "BookTag");
    }

    @NSManaged public var book: Books?
    @NSManaged public var tags: Tags?

}
