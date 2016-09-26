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


//
////MARK: - KVO
//extension BookTag{
//    static func observableKeys() -> [String] {return ["Book.Images.image"]}
//    
//    func setupKVO(){
//        
//        
//        
//        for key in BookTag.observableKeys(){
//            self.addObserver(self, forKeyPath: key,
//                             options: [], context: nil)
//        }
//        
//        
//    }
//    
//    func teardownKVO(){
//        
//        // Baja en todas las notificaciones
//        for key in BookTag.observableKeys(){
//            self.removeObserver(self, forKeyPath: key)
//        }
//        
//        
//    }
//    
//    
//}
//
//
////MARK: - Lifecycle
//extension BookTag{
//    
//    // Se llama una sola vez
//    public override func awakeFromInsert() {
//        super.awakeFromInsert()
//        
//        setupKVO()
//    }
//    
//    // Se llama un huevo de veces
//    public override func awakeFromFetch() {
//        super.awakeFromFetch()
//       
//        setupKVO()
//    }
//    
//    public override func willTurnIntoFault() {
//        super.willTurnIntoFault()
//        
//        teardownKVO()
//    }
//}
//
