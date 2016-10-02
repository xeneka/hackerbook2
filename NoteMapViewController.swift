//
//  NoteMapViewController.swift
//  hackerbookv2
//
//  Created by Antonio Benavente del Moral on 1/10/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import UIKit
import CoreData
import MapKit


class NoteMapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadLocalIniciation()
        
        mapNote.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadNoteInMap()
    }
    
    
    @IBOutlet weak var mapNote: MKMapView!
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}



extension NoteMapViewController {
    
    func loadNoteInMap(){
    
        struct notepin{
           
            
        }
        
        let fetch = NSFetchRequest<Annotations>(entityName: Annotations.entityName)
        let sort = NSSortDescriptor(key: "annontation", ascending: true)
        
        let result = try! model?.context.fetch(fetch)
        
        for each in result! {
            
           
        
            let note = noteInMap(tag: each)
        
            mapNote.addAnnotation(note)
            

            
            
            print(each.annontation,each.geo?.latitude)
            
        }
    
    
    }
    

}

//MARK: - util

extension NoteMapViewController {
    
    func loadLocalIniciation(){
    
        // Centramos la localizacion del mapa
        
        let initLocation = CLLocationCoordinate2D(latitude: 37.8833333, longitude: -4.7666667)
        
        let region = MKCoordinateRegionMakeWithDistance(initLocation, 2000, 2000)
        
        mapNote.setRegion(region, animated: true)
        
        
    }
    
    
}

extension NoteMapViewController:MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        
        
        let idpin = "pin"
        
        var view:MKPinAnnotationView
        
        if let dequeuedView = mapNote.dequeueReusableAnnotationView(withIdentifier: idpin) as? MKPinAnnotationView {
            
            dequeuedView.annotation = annotation
            
            view = dequeuedView
            
        }else{
            
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: idpin)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
       return view
        
    }
    
    
}


class noteInMap:NSObject ,MKAnnotation{
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(tag:Annotations){

       
        if let geoData  = tag.geo {
           
            coordinate = CLLocationCoordinate2D(latitude:geoData.latitude, longitude: geoData.longitude )
            
        }else{
            
            // Inicialmente hasta aclarar la duda del GPS que no funciona
            
            coordinate = CLLocationCoordinate2D(latitude: 37.8833333, longitude: -4.7666667)
        }
        
       
       title = tag.annontation
       
       super.init()
        
    }
    
   
    
    
}




