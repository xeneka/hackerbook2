//
//  PdfBook+CoreDataClass.swift
//  hackerbookv2
//
//  Created by Antonio Benavente del Moral on 18/9/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import Foundation
import CoreData


public class PdfBook: NSManagedObject {

    static let entityName = "PdfBook"

    convenience init(pdfdata: Data, book: Books, inContext context: NSManagedObjectContext) {
        
        let entity = NSEntityDescription.entity(forEntityName: PdfBook.entityName, in: context)!
        
        self.init(entity:entity, insertInto:context)
        
        self.books = book
        self.dataPdf = pdfdata as NSData?
        
        
    }
    
    
}
