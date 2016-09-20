//
//  BookTag+CoreDataClass.swift
//  hackerbookv2
//
//  Created by Antonio Benavente del Moral on 20/9/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import Foundation
import CoreData


public class BookTag: NSManagedObject {

    
    static let entityName = "BookTag"

    convenience init(book:Books, tag:Tags, inContext context:NSManagedObjectContext) {
        
        let entity = NSEntityDescription.entity(forEntityName: BookTag.entityName, in: context)!
        
        self.init(entity:entity, insertInto:context)
        
        self.book = book
        self.tags = tag
    }
    
    
}
