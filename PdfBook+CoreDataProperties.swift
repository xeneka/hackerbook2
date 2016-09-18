//
//  PdfBook+CoreDataProperties.swift
//  hackerbookv2
//
//  Created by Antonio Benavente del Moral on 18/9/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import Foundation
import CoreData


extension PdfBook {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PdfBook> {
        return NSFetchRequest<PdfBook>(entityName: "PdfBook");
    }

    @NSManaged public var dataPdf: NSData?
    @NSManaged public var books: Books?

}
