//
//  Image+CoreDataClass.swift
//  hackerbookv2
//
//  Created by Antonio Benavente del Moral on 18/9/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import Foundation
import CoreData


public class Image: NSManagedObject {

    static let entityName = "Image"
    
    convenience init(image: Data, book:Books, context: NSManagedObjectContext){
        
        let entity = NSEntityDescription.entity(forEntityName: Image.entityName, in: context)!
        
        self.init(entity:entity, insertInto:context)
        
        self.books = book
        self.image = image as NSData?
        
        
        
        
    }
    
    convenience init(image: Data, note:Annotations, context: NSManagedObjectContext){
        
        let entity = NSEntityDescription.entity(forEntityName: Image.entityName, in: context)!
        
        self.init(entity:entity, insertInto:context)
        
        self.annotations = note
        self.image = image as NSData?
        
        
    }
    
    convenience init(image:Data, context: NSManagedObjectContext){
       
        let entity = NSEntityDescription.entity(forEntityName: Image.entityName, in: context)!
        
        self.init(entity:entity, insertInto:context)
        
        self.image = image as NSData?
        
    }
    
    
    
    
}





