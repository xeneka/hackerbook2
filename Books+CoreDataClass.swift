//
//  Books+CoreDataClass.swift
//  hackerbookv2
//
//  Created by Antonio Benavente del Moral on 18/9/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import Foundation
import CoreData


public class Books: NSManagedObject {

    static let entityName = "Books"
    convenience init(title:String, pdfUrl:String,downloadFile:Bool, inContext context:NSManagedObjectContext) {
        
        //Cogemos la entidad
        
        let entity = NSEntityDescription.entity(forEntityName: Books.entityName, in: context)!
        
        // llamamos a Super
        
        self.init(entity:entity, insertInto:context)
        
        // Insertamos los datos
        
        self.title = title
        self.urlPdf = pdfUrl
        self.download = downloadFile
        
    }
    
    
    
    
}




