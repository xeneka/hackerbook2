//
//  BooksTableViewController.swift
//  hackerbookv2
//
//  Created by Antonio Benavente del Moral on 19/9/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import UIKit
import CoreData

class BooksTableViewController: CoreDataTableViewController {

    fileprivate var fr = NSFetchRequest<BookTag>(entityName: BookTag.entityName)
    fileprivate var searchBar:UISearchBar?
    static var reenviar = true
    
    
    // inicializo clase para utilizar el contexto
    
    init (context:NSManagedObjectContext){
        
        //fr = NSFetchRequest<BookTag>(entityName: BookTag.entityName)
        fr.fetchBatchSize = 50
        
        fr.sortDescriptors=[NSSortDescriptor(key:"tags.orderTag", ascending:true)]
        
        let fc = NSFetchedResultsController(fetchRequest: fr, managedObjectContext: (model?.context)!, sectionNameKeyPath: "tags.orderTag", cacheName: nil)
        
        
        super.init(fetchedResultsController: fc as! NSFetchedResultsController<NSFetchRequestResult>)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
        self.navigationItem.hidesBackButton = true
        
       
        
        // Do any additional setup after loading the view.
    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        upSearchBar()
        
        // Compruebo si habia leido un libro anterior mente lo cargo y hago un push
        
        if (BooksTableViewController.reenviar){
        
        BooksTableViewController.reenviar=false
            
            
        guard let bookTagRecover = recoverObjFromUserDefault(key: "lastBook") else{
                return
            }
            
        let datos = bookTagRecover as! BookTag
        
            if( datos.book?.title != nil){
               
                // Envio al Controlador
                
                let nVC = PdfViewController(bookTag: bookTagRecover as! BookTag)
                
                navigationController?.pushViewController(nVC, animated: true)
            }
            
        
        
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CellBookTableViewCell.cellHeight
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let booktag = fetchedResultsController?.object(at: indexPath) as! BookTag
        let cell = tableView.dequeueReusableCell(withIdentifier: CellBookTableViewCell.cellId) as! CellBookTableViewCell
        cell.accessoryType = UITableViewCellAccessoryType.detailDisclosureButton
        cell.startObserving(bookTag: booktag)
        
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Fech cell
        
        let booktag = fetchedResultsController?.object(at: indexPath) as! BookTag
        
        
        // Grabo el ultimo libro seleccionado
        
        
        saveObjData(obj: booktag, key: "lastBook")
        

        // Envio al Controlador
        
        let nVC = PdfViewController(bookTag: booktag)
        
        navigationController?.pushViewController(nVC, animated: true)
        
        
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

extension BooksTableViewController{
    
    func registerNib(){
        let nib = UINib(nibName: "CellBookTableViewCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: CellBookTableViewCell.cellId)
        
    }
    
}

//MARK: - searchbar


extension BooksTableViewController{
    
    // Arranco la barra
    
    
    
    func upSearchBar(){
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        self.tableView.tableHeaderView = searchBar
        searchBar?.delegate = self
    }
    
}

extension BooksTableViewController:UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    

        
        if (self.searchBar?.text != ""){
            
            let libro = NSPredicate(format: "book.title BEGINSWITH[c] %@", searchBar.text!)
            let categoria = NSPredicate(format: "tags.tag BEGINSWITH[c] %@", searchBar.text!)
            let filter = NSCompoundPredicate(orPredicateWithSubpredicates: [libro, categoria])
            
            self.fr.predicate = filter
           
        } else{
            
            self.fr.predicate = nil
            
            
        }
        
        self.fr.fetchBatchSize = 50
        let result = NSFetchedResultsController(fetchRequest: self.fr, managedObjectContext: (model?.context)!, sectionNameKeyPath: "tags.orderTag", cacheName: nil)
        self.fetchedResultsController = result as? NSFetchedResultsController<NSFetchRequestResult>

        
    }
    
}


