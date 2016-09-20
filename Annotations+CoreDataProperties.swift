//
//  Annotations+CoreDataProperties.swift
//  hackerbookv2
//
//  Created by Antonio Benavente del Moral on 20/9/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import Foundation
import CoreData
 

extension Annotations {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Annotations> {
        return NSFetchRequest<Annotations>(entityName: "Annotations");
    }

    @NSManaged public var annontation: String?
    @NSManaged public var dateCreate: NSDate?
    @NSManaged public var dateModification: NSDate?
    @NSManaged public var books: Books?
    @NSManaged public var geo: Geo?
    @NSManaged public var image: Image?

}
