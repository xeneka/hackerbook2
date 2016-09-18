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


//MARK: - KVO

extension Books{
    
    static func observableKeys() -> [String] {return ["download", "favorite"]}
    
    func setupKVO(){
        
        for each in Books.observableKeys(){
            self.addObserver(self, forKeyPath: each, options: [], context: nil)
        }
        
    }
    
    func teardownKVO(){
        
        for each in Books.observableKeys(){
            self.removeObserver(self, forKeyPath: each)
        }
        
    }
    
}



//MARK: - lifecycle


//MARK: - Lifecycle
//extension Books{
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



