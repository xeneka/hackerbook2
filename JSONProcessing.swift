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
let model = CoreDataStack(modelName: "Model")
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


//Struct del libro

typealias Author = String
typealias Authorsx = [Author]
typealias Title = String
typealias PDF = String
typealias Imagex = String

struct Book{
    let _authors : Authorsx
    let _title   : Title
    var _tags    : Tags
    let _pdf     : PDF
    let _image   : Imagex

}






func decode(books dicts: JSONArray){
    
    do{
    _ = try dicts.flatMap{
        
        
        try decode(book:$0)
    }
     
        model?.save()
        
        
        
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
       let _ = Tags(tag: each, book: book, inContext: (model?.context)!)
    }

    
    
    let _ = Image(image: imageByDefault, book: book, context: (model?.context)!)
    
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



