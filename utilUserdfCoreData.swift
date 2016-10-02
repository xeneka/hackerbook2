//
//  utilUserdfCoreData.swift
//  hackerbookv2
//
//  Created by Antonio Benavente del Moral on 2/10/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import Foundation
import CoreData


func saveObjData<T:NSManagedObject>(obj:T, key:String){
    
    // Obtengo la URI del objecto
    
    let url = obj.objectID.uriRepresentation()
    
    let userDef = UserDefaults.standard

    // La guardo en User Default
    
    let data = NSKeyedArchiver.archivedData(withRootObject: url)

    
    userDef.set(data, forKey: key)
    
    
}

func recoverObjFromUserDefault(key:String) -> AnyObject?{
    
    // Recupero la uri de SandBox
    
    let userDef = UserDefaults.standard
    
    // verifico que existe la key
    
    guard  let datos:Data = userDef.value(forKey: key) as? Data else{
        
        return nil
    }
    
    guard let uri:URL = NSKeyedUnarchiver.unarchiveObject(with: datos) as! URL? else{
        return nil
    }
    
    
    guard let nid = model?.context.persistentStoreCoordinator?.managedObjectID(forURIRepresentation: uri) else {
        return nil
    }
    
    let ob = model?.context.object(with: nid)
    
    if (ob?.isFault)!{
        
        return ob
    }else{
        
        let req = NSFetchRequest<BookTag>(entityName: (ob?.entity.name)!)
        
       req.predicate = NSPredicate(format: "SELF =%@", ob!)
        
        do{
        let result = try model?.context.fetch(req)
            
            return result?.last
            
        }catch{
            return nil
        }
    }
    
    
return nil

    
}
