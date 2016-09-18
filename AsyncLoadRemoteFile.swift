//
//  AsyncLoadRemoteFile.swift
//  hackerbookv2
//
//  Created by Antonio Benavente del Moral on 13/9/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//


// TO DO
// Wrapper download file.
// 1) Download Url File in BackGround
// 2) Info Pogress
// 3) Info Errores


import Foundation

public
class DownloadUrlFile{
    
    let url : URL
    fileprivate var _data:Data?   // no data to the end of the load
    weak public var delegate: DownloadUrlFileDelegate?
    
    
    
    init(_ url:URL){
        self.url = url
    
    }
    
    init(_ url:String){
        self.url = URL(string: url)!
    }
    
    
    // Habría que implementar el uso de multiples colar para decargar pdf, images cada una por su cola
    
    public func downloadAsyncFile(){
        
        DispatchQueue.global(qos: .default).async {
            
            do{
            
            try self._data = Data(contentsOf: self.url)
                
                DispatchQueue.main.async {
                    
                    self.delegate?.DownloadUrlFile(self, didEndLoadingFrom: self.url)
                    print(self._data)
                    
                }
                
            }catch{
               print("Error")
            }
        }
        
    }
    
    
    public func doSomeThingWithDownLoadFile(_ completion:@escaping (_ result:Any)->()){
    
        DispatchQueue.global(qos: .default).async {
            
            do{
                
                try self._data = Data(contentsOf: self.url)
                
                DispatchQueue.main.async {
                    
                    completion(self._data);
                    
                }
                
            }catch{
                print("Error")
            }
        }
    
    }
    
    
    
    
    
}
//MARK: - notificaciones 





//MARK: - Delegate


public protocol DownloadUrlFileDelegate:class{
    
   func DownloadUrlFile(_ sender: DownloadUrlFile, shouldStartLoadingFrom url: URL )->Bool
   func DownloadUrlFile(_ sender: DownloadUrlFile, willStartLoadingFrom url: URL )
   func DownloadUrlFile(_ sender: DownloadUrlFile, didEndLoadingFrom url: URL )
   func DownloadUrlFile(_ sender: DownloadUrlFile, didFailLoadingFrom url: URL, error: NSError )
    
    
}


//MARK: - Default implementation

extension DownloadUrlFileDelegate{
    
//    func DownloadUrlFile(_ sender: DownloadUrlFile, shouldStartLoadingFrom url: URL ) ->Bool{
//        return true
//    }
    
    func DownloadUrlFile(_ sender: DownloadUrlFile, willStartLoadingFrom url: URL ){
        print("File init **********");
    }
    
    func DownloadUrlFile(_ sender: DownloadUrlFile, didFailLoadingFrom url: URL, error: NSError ){
        print("Fail in Loading ", error)
    }
    
    func DownloadUrlFile(_ sender: DownloadUrlFile, didEndLoadingFrom url: URL ){
          print("File download **********");
    }
    
}





