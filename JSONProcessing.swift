//
//  JSONProcessing.swift
//  hackerbookv2
//
//  Created by Antonio Benavente del Moral on 16/9/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import Foundation
import CoreData



// Variable para todos los procesos
//let model = CoreDataStack(modelName: "Model")
let mainBundle = Bundle.main

let defaultImage = mainBundle.url(forResource: "emptyBookCover", withExtension: "png")!
let imageByDefault = try! Data(contentsOf: defaultImage)


let defaultPdf = mainBundle.url(forResource: "emptyPdf", withExtension: "pdf")!
let pdfbydefault = try! Data(contentsOf: defaultPdf)

let finishLoadDataFromJSON = NSNotification.Name("finishLoadJSON")


//MARK: - Errors
enum JSONErrors : Error{
    case missingField(name:String)
    case incorrectValue(name: String, value: String)
    case emptyJSONObject
    case emptyJSONArray
}


//MARK: - Aliases
typealias JSONObject    = String    // We'll only receive strings
typealias JSONDictionary = [String : JSONObject]
typealias JSONArray = [JSONDictionary]





func decode(books dicts: JSONArray){
    
    try! model?.dropAllData()
    
    // Doy de alta el Tag Favoritos
    
    let _ = Tags(tag: "favorite", ordertg: "_favorite", inContext: (model?.context)!)
    
    
    // Cargo los datos del JSON
    
    do{
    _ = try dicts.flatMap{
        
        
        try decode(book:$0)
    }
     
       
       
        
        model?.save {
            
                    }
        
        let notification = NSNotification(name: finishLoadDataFromJSON, object: nil)
        
        let nc = NotificationCenter.default
        
        nc.post(notification as Notification)
        
        
        
       
        
    }catch{
        print("Error detected in JSONArray dict")
    }
    
    
    
    
    
}






func decode(book dict: JSONDictionary) throws{
    
    // validate first
    try validate(dictionary: dict)
    
    // extract from dict
    func extract(key: String) -> String{
        return dict[key]!   // we know it can't be missing because we validated first!
    }
    
    // parsing
    let authors = parseCommaSeparated(string: extract(key: "authors"))
    let imgURL = URL(string: extract(key: "image_url"))!
    let pdfURL = URL(string: extract(key: "pdf_url"))!
    let tags = parseCommaSeparated(string: extract(key: "tags"))
    let title = extract(key: "title").capitalized
    
    //let mainBundle = Bundle.main
    
    //let defaultImage = mainBundle.url(forResource: "emptyBookCover", withExtension: "png")!
    //let defaultPdf = mainBundle.url(forResource: "emptyPdf", withExtension: "pdf")!
    
     // Guardar en la Base de datos
    
  
    
    // Descargar en Segundo plano la imagenes y pdf
    
    
    
    let book = Books(title: title, pdfUrl: pdfURL.absoluteString, downloadFile: false, inContext: (model?.context)!)
    
    
    for each in authors{
        let _ = Authors(name: each, book: book, inContext: (model?.context)!)
    }

   for each in tags{
       let newTag = Tags(tag: each, inContext: (model?.context)!)
    
        let _ = BookTag(book: book, tag: newTag, inContext: (model?.context)!)
    
    }

    
    
    let _ = Image(image: downloadImage(url: imgURL, image: imageByDefault, book: book), book: book, context: (model?.context)!)
    
    
    // Iniciar la descarga en segundo plano de la imagen
    
    let _ = PdfBook(pdfdata: pdfbydefault, book: book, inContext: (model?.context)!)
    
    // El pdf no se descarga en segundo plano hasta que el usuario elige verlo
    
   
    
    
    
    return
  
    
}



//MARK: - Validation
// Validation should be kept waya from processing to
// insure the single responsability principle
// https://medium.com/swift-programming/why-swift-guard-should-be-avoided-484cfc2603c5#.bd8d7ad91
private
func validate(dictionary dict: JSONDictionary) throws{
    
    func isMissing() throws{
        for key in dict.keys{
            guard let value = dict[key] else{
                throw JSONErrors.missingField(name: key)
            }
            guard value.characters.count > 0  else {
                throw JSONErrors.incorrectValue(name: key, value: value)
            }
        }
        
    }
    
    try isMissing()
    
}


//MARK: - Parsing
func parseCommaSeparated(string s: String)->[String]{
    
    return s.components(separatedBy: ",").map({ $0.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }).filter({ $0.characters.count > 0})
}



//MARK: -  Utils

func downloadImage(url:URL, image:Data, book:Books) -> Data {
    
    // Defino la Url sobre la que se tiene que descargar el fichero
    let datos:DownloadUrlFile = DownloadUrlFile(url);
    
    // Hago la descarga del fichero en segundo plano y le paso una trailing closure decodifica el JSON en este caso
    
    
    datos.doSomeThingWithDownLoadFile { (parametro: Any) in
        do {
            let image = parametro as! NSData
            book.images?.image = image
        }catch{
            print("Error")
            
              }

}

    return image
}
