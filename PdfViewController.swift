//
//  PdfViewController.swift
//  hackerbookv2
//
//  Created by Antonio Benavente del Moral on 22/9/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import UIKit

class PdfViewController: UIViewController {

    var _booktag:BookTag?
    
    init(bookTag:BookTag){
    
        super.init(nibName: nil, bundle: nil)
        _booktag = bookTag
        
    }
    
    @IBAction func favorite(_ sender: AnyObject) {
        _booktag?.book?.favorite = !(_booktag?.book?.favorite)!
    }
    
    @IBOutlet weak var pdfbook: UIWebView!
    
    
    @IBAction func NewNote(_ sender: AnyObject) {
        
        let nVC = NoteViewController(bookTag: self._booktag!)
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

