//
//  AppDelegate.swift
//  hackerbookv2
//
//  Created by Antonio Benavente del Moral on 12/9/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import UIKit
import CoreData


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Create the window
        window = UIWindow.init(frame: UIScreen.main.bounds)
        let nVC:UIViewController
        
        
        // Verifico si ya la url ya se ha descargado, si no se ha descargado lo descargo 
        
        let descarga = false
        
        if (descarga){
            
            let fr = NSFetchRequest<BookTag>(entityName: BookTag.entityName)
            fr.fetchBatchSize = 50
            
            fr.sortDescriptors=[NSSortDescriptor(key:"tags", ascending:false)]
            
            let fc = NSFetchedResultsController(fetchRequest: fr, managedObjectContext: (model?.context)!, sectionNameKeyPath: nil, cacheName: nil)
            
            print("----")
            
            NSLog("%@", fr);
            
            
            let nVC = BooksTableViewController(fetchedResultsController: fc as! NSFetchedResultsController<NSFetchRequestResult>, style: .plain)
            //let nVC = PruebaViewController()
            
            
            let navVC = UINavigationController(rootViewController: nVC)
            window = UIWindow(frame: UIScreen.main.bounds)
            
            window?.rootViewController = navVC
            window?.makeKeyAndVisible()

            
        }else{
        
        
        // si no se ha desargado
        
        nVC = LoadViewController()
        let navVC = UINavigationController(rootViewController: nVC)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
        
        
        // Inicio Descarga del JSON
        
        // Defino la Url sobre la que se tiene que descargar el fichero
        let datos:DownloadUrlFile = DownloadUrlFile("https://t.co/K9ziV0z3SJ");
        
        // Hago la descarga del fichero en segundo plano y le paso una trailing closure decodifica el JSON en este caso
        datos.doSomeThingWithDownLoadFile { (parametro: Any) in
            
            
            do {
            let jsonDicts = try JSONSerialization.jsonObject(with: parametro as! Data, options: JSONSerialization.ReadingOptions.mutableContainers) as? JSONArray
                
                try decode(books: jsonDicts!)
                
                
            }catch{
                print("Error")
            }
        }
        
        
        }
        
       
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

