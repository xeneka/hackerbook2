//
//  Image+CoreDataProperties.swift
//  hackerbookv2
//
//  Created by Antonio Benavente del Moral on 6/10/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import Foundation
import CoreData


extension Image {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: "Image");
    }

    @NSManaged public var image: NSData?
    @NSManaged public var annotations: Annotations?
    @NSManaged public var books: Books?

}
