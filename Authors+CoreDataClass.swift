//
//  Authors+CoreDataClass.swift
//  hackerbookv2
//
//  Created by Antonio Benavente del Moral on 18/9/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import Foundation
import CoreData


public class Authors: NSManagedObject {

    static let entityName = "Authors"
    
    convenience init(name:String, book:Books, inContext: NSManagedObjectContext) {
        
       // Cogemos la entidad
        
       let entity = NSEntityDescription.entity(forEntityName: Authors.entityName, in: inContext)!
        
        // Llamamos a Super
        
        self.init(entity:entity, insertInto: inContext)
        
        // Actualizamos el Modelo
        
       self.authorName = name
       self.addToBooks(book)
        
    }
    
    
    
    
}
