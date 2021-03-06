//
//  PdfViewController.swift
//  hackerbookv2
//
//  Created by Antonio Benavente del Moral on 22/9/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import UIKit
import CoreData
import Social

class PdfViewController: UIViewController {

    var _booktag:BookTag?
    
    init(bookTag:BookTag){
    
        super.init(nibName: nil, bundle: nil)
        _booktag = bookTag
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        self.title = _booktag?.book?.title
       
        
    }
    
    @IBAction func favorite(_ sender: AnyObject) {
        _booktag?.book?.favorite = !(_booktag?.book?.favorite)!
        
    }
    
    @IBAction func sharedBook(_ sender: AnyObject) {
        
        let alert = UIAlertController(title: "Comparte el Libro", message: nil, preferredStyle: .alert)
        let twitterAction = UIAlertAction(title: "Share in Twitter", style: .default) { _ in
            let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            vc?.setInitialText("\(self._booktag?.book?.title)")
            if let photoToShare = UIImage(data: (self._booktag?.book?.images?.image)! as Data) {
                vc?.add(photoToShare)
            }
            
            self.present(vc!, animated: true, completion: nil)
        }
        alert.addAction(twitterAction)
        
        let facebookAction = UIAlertAction(title: "Share in Facebok", style: .default) { _ in
            let vc = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            vc?.setInitialText("\(self._booktag?.book?.title)")
            if let photoToShare = UIImage(data: (self._booktag?.book?.images?.image)! as Data) {
                vc?.add(photoToShare)
            }
            self.present(vc!, animated: true, completion: nil)
        }
        alert.addAction(facebookAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
        
        
        
    }
    @IBOutlet weak var pdfbook: UIWebView!
    
    
    @IBAction func NewNote(_ sender: AnyObject) {
        
        let nVC = NoteViewController(bookTag: self._booktag!)
        navigationController?.pushViewController(nVC, animated: true)
        
    }
    
    @IBAction func isFavorite(_ sender: AnyObject) {
        
        
        // El libro no esta marcado como favorito
        if (!(_booktag?.book?.favorite)!){
           let _ = BookTag(book: (_booktag?.book)!, tag: selectFavoriteTag()!, inContext: (model?.context)!)
            
        }else{
            deleteFavoriteTag()
        }
        
        
        _booktag?.book?.favorite = !(_booktag?.book?.favorite)!
    }
    
    
    @IBAction func viewNotes(_ sender: AnyObject) {
        
       
      
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 5, bottom: 10, right: 5)
        layout.itemSize = CGSize(width: 200, height: 200)
        
        
        let nVC = ListNoteCollectionViewController(book: (_booktag?.book)!)
    
        //var nVC = ListNoteCollectionViewController(collectionViewLayout: layout)
        
        self.navigationController?.pushViewController(nVC, animated: true)
        
        
    }

    
    @IBAction func notesInMap(_ sender: AnyObject) {
        
        let nVC = NoteMapViewController()
        navigationController?.pushViewController(nVC, animated: true)
      
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pdfbook.load((_booktag?.book?.pdfbook?.dataPdf)! as Data, mimeType: "application/pdf", textEncodingName: "utf8", baseURL: URL(string:"http://www.google.com")!)

        downLoadBook()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}


extension PdfViewController{
    
    func downLoadBook(){
        
        if (!(_booktag?.book?.download)!){
            
            let datos = DownloadUrlFile((_booktag?.book?.urlPdf)!)
            
            datos.doSomeThingWithDownLoadFile({ (libro) in
                self._booktag?.book?.download = true
                self._booktag?.book?.pdfbook?.dataPdf = libro as? NSData
                self.pdfbook.load((self._booktag?.book?.pdfbook?.dataPdf)! as Data, mimeType: "application/pdf", textEncodingName: "utf8", baseURL: URL(string:"http://www.google.com")!)

                
            })
            
        }
        
    }
    
}


//MARK: -  util

extension PdfViewController{


    func selectFavoriteTag() -> Tags? {
        let fetch = NSFetchRequest<Tags>(entityName: "Tags")
        let predicate = NSPredicate(format: "tag == %@", "favorite")
        let sort = NSSortDescriptor(key: "tag", ascending: true)
        //let tagFavorite:[Tags]?
        fetch.predicate = predicate
        fetch.sortDescriptors = [sort]
        do{
            let tagFavorite = try model?.context.fetch(fetch)
            return (tagFavorite?.first)!
        }catch let error {
            print(error)
        }
        
        return nil
        
    }
    
    func deleteFavoriteTag(){
        let fetch = NSFetchRequest<BookTag>(entityName: BookTag.entityName)
        let tagPredicate = NSPredicate(format: "tags.orderTag == %@", "_favorite")
        let bookPredicate = NSPredicate(format: "book == %@", (_booktag?.book)!)
        let filter = NSCompoundPredicate(andPredicateWithSubpredicates: [tagPredicate, bookPredicate])
        let sort = NSSortDescriptor(key: "tags.tag" ,ascending:true)
        
        
        fetch.predicate = filter
        fetch.sortDescriptors = [sort]
        
        let borrar = try! model?.context.fetch(fetch)
        
        for each in borrar! {
            
            
            model?.context.delete(each)
        }
       
        
        
        
        
        
        
        
        
        
    }
    

}

