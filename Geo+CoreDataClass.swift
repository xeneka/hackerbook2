//
//  Geo+CoreDataClass.swift
//  hackerbookv2
//
//  Created by Antonio Benavente del Moral on 18/9/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import Foundation
import CoreData
import CoreLocation



public class Geo: NSManagedObject {

    static let entityName = "Geo"
    
    convenience init(location: CLLocation, nota:Annotations, inContext context: NSManagedObjectContext) {
        
        let entity = NSEntityDescription.entity(forEntityName: Geo.entityName, in: context)!
        
        self.init(entity:entity, insertInto:context)
     
       
        
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
        self.annotation = nota
        
//        let geoCoder = CLGeocoder()
//        
//        geoCoder.reverseGeocodeLocation(location) { (placemark, error) in
//            
//            if ((error) != nil){
//                print ("Error en la localización inversa")
//            }
//            
//            
//            
//            print("***",placemark?.description)
//            
//         }   
        
            
            
            
        
        
    }
    
    
}
