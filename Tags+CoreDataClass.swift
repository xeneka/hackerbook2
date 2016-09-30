//
//  Tags+CoreDataClass.swift
//  hackerbookv2
//
//  Created by Antonio Benavente del Moral on 18/9/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import Foundation
import CoreData


public class Tags: NSManagedObject {

    
    static let entityName = "Tags"
    
    convenience init(tag:String, inContext context:NSManagedObjectContext) {
        
        let entity = NSEntityDescription.entity(forEntityName: Tags.entityName, in: context)!
        
        self.init(entity:entity, insertInto:context)
        
        self.tag = tag
        self.orderTag = tag
       
        
        
    }
    
    convenience init(tag:String, ordertg: String, inContext context:NSManagedObjectContext) {
        
        let entity = NSEntityDescription.entity(forEntityName: Tags.entityName, in: context)!
        
        self.init(entity:entity, insertInto:context)
        
        self.tag = tag
        self.orderTag = ordertg
        
        
        
    }
    
    
}
