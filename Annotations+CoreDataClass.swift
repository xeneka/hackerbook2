//
//  Annotations+CoreDataClass.swift
//  hackerbookv2
//
//  Created by Antonio Benavente del Moral on 18/9/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import Foundation
import CoreData
import CoreLocation


public class Annotations: NSManagedObject {

    static let entityName = "Annotations"

    // Declaro el location manager
    fileprivate let posicion = CLLocationManager()
    
    convenience init(title:String,image:Data , book: Books, inContext context:NSManagedObjectContext) {
        
        let entity = NSEntityDescription.entity(forEntityName: Annotations.entityName, in: context)!
        
        self.init(entity:entity, insertInto:context)
        
        self.annontation = title
        self.dateCreate = NSDate()
        self.dateModification = NSDate()
        self.books = book
        
        let noteImage = Image(image: image, context: context)
        
        self.image = noteImage
        
        
        
        
        
        }
        
    }
    
    



//MARK: - KVO
extension Annotations{
    static func observableKeys() -> [String] {return ["annontation","image.Image"]}
    
    func setupKVO(){
        
        
        
        for key in Annotations.observableKeys(){
            self.addObserver(self, forKeyPath: key,
                             options: [], context: nil)
        }
        
        
    }
    
    func teardownKVO(){
        
        // Baja en todas las notificaciones
        for key in Annotations.observableKeys(){
            self.removeObserver(self, forKeyPath: key)
        }
        
        
    }
    
    
    public override func observeValue(forKeyPath keyPath: String?,
                                      of object: Any?,
                                      change: [NSKeyValueChangeKey : Any]?,
                                      context: UnsafeMutableRawPointer?) {
        
        // actualizar modificationDate
        self.dateModification = NSDate()
        starGps()
        
       
    }
    
    
}


//MARK: - Lifecycle
extension Annotations{
    
    // Se llama una sola vez
    public override func awakeFromInsert() {
        super.awakeFromInsert()
    
        
        
         setupKVO()
        
        
    }
    
    // Se llama un huevo de veces
    public override func awakeFromFetch() {
        super.awakeFromFetch()
        
        setupKVO()
       
        
        
        
    }
    
    public override func willTurnIntoFault() {
        super.willTurnIntoFault()
        
        teardownKVO()
    }
    
    public func starGps(){
        posicion.requestAlwaysAuthorization()
        posicion.requestWhenInUseAuthorization()
        
        let status = CLLocationManager.authorizationStatus()
        
        // Compruebo si tengo acceso a la localización
        
        if (!(status == CLAuthorizationStatus.denied) ){
            
            // Configuro el location manager
            
            posicion.delegate = self
            
            posicion.desiredAccuracy = kCLLocationAccuracyBest
            
            // Empieza a funcionar
            posicion.startUpdatingLocation()
            
            
            
        }else{
            print("No tienes autorizacion para ejecutar Location Manager")
        }
        
        
        
        
        

    }
    
    
}


extension Annotations:CLLocationManagerDelegate{
    
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print(Error.self)
    }
    
    
    @objc(locationManager:didUpdateLocations:) public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Paramos que siga buscando la localiación. Consume mucha bateria
        
        self.posicion.stopUpdatingLocation()
        
       
        
        let notaGeo = Geo(location: locations.last!, nota: self, inContext: self.managedObjectContext!)
        
        
        
        //self.geo = notaGeo
        
    }
    
    
}




