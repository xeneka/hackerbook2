//
//  LoadViewController.swift
//  hackerbookv2
//
//  Created by Antonio Benavente del Moral on 19/9/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import UIKit
import CoreData

class LoadViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var stopLoading: UIActivityIndicatorView!
    
    override func viewWillAppear(_ animated: Bool) {
        

        
       setupNotification()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tearDownNotification()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: - util

extension LoadViewController{
    
    
    
    func setupNotification(){
        
        
    
        let nc = NotificationCenter.default
        
        let _ = nc.addObserver(forName: NSNotification.Name("finishLoadJSON"), object: nil, queue: OperationQueue.main)
        { (n:Notification) in
            self.stopLoading.stopAnimating()
            
            
            let fr = NSFetchRequest<BookTag>(entityName: BookTag.entityName)
            fr.fetchBatchSize = 50
            
            fr.sortDescriptors=[NSSortDescriptor(key:"tags.orderTag", ascending:true)]
            
            let fc = NSFetchedResultsController(fetchRequest: fr, managedObjectContext: (model?.context)!, sectionNameKeyPath: "tags.orderTag", cacheName: nil)
            
           
            
            
//          let nVC = BooksTableViewController(fetchedResultsController: fc as! NSFetchedResultsController<NSFetchRequestResult>, style: .plain)
         
            let nVC = BooksTableViewController(context: (model?.context)!)
            
            
            self.navigationController?.pushViewController(nVC, animated: true)
            
            
            
        }
    }
    
    func tearDownNotification(){
        NotificationCenter.default.removeObserver(self)
        
        
    }
    
    
    
    
}


