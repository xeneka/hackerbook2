//
//  NoteViewController.swift
//  hackerbookv2
//
//  Created by Antonio Benavente del Moral on 23/9/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController {

    fileprivate var _bookTag:BookTag?
    
    init(bookTag:BookTag){
        super.init(nibName: nil, bundle: nil)
        _bookTag = bookTag
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapCloseKeyboard()
        textNote.delegate = self
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var photoImage: UIImageView!

    @IBOutlet weak var textNote: UITextField!
    @IBAction func saveNote(_ sender: AnyObject) {
        
        let nota = Annotations(title: textNote.text!, image: UIImageJPEGRepresentation(photoImage.image!, 0.9)! as Data, book: (_bookTag?.book)!, inContext: (_bookTag?.managedObjectContext)!)
        
        
    }
    
    @IBAction func takePhoto(_ sender: AnyObject) {
        
        // Crear una instancia de UIImagePicker
        let picker = UIImagePickerController()
        
        // Configurarlo
        if UIImagePickerController.isCameraDeviceAvailable(.rear){
            picker.sourceType = .camera
        }else{
            // me conformo con el carrete
            picker.sourceType = .photoLibrary
        }
        
        
        picker.delegate = self
        
        // Mostrarlo de forma modal
        self.present(picker, animated: true) {
            // Por si quieres hacer algo nada más
            // mostrarse el picker
        }
        
        
        
    }
    
    
   
}

//MARK: - Delegate

extension NoteViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
         photoImage.image = info[UIImagePickerControllerOriginalImage] as! UIImage?
        
        
//        guard  let imagePicker = info[UIImagePickerControllerOriginalImage] as! UIImage? else{
//            print("Imagen no Valida")
//            return
//        }
//        
//        let image = UIImageJPEGRepresentation(imagePicker, 1)
//        
        
        
        
      
        //_bookTag?.book?.addNote(note: nota, inContext: (_bookTag?.managedObjectContext)!)
      
        // Antes de guardar nota tiene asignado un libro
        //try! _bookTag?.managedObjectContext?.save()
        // Despues de guardar no lo tiene
        
        
        // Quitamos de enmedio al picker
        self.dismiss(animated: true) {
            //
        }

    }
    
    
}



//MARK: - observingkeyboard


extension NoteViewController{
    
    
    // Observo las varibles que activan y desactivan el teclado
    func startObserving(){
    
    let showKeyBoard = Notification.Name(rawValue: "UIKeyboardWillShowNotification")
    let closeKeyBoard = Notification.Name(rawValue: "UIKeyboardWillHideNotification")
        
    let nc = NotificationCenter.default
    nc.addObserver(forName: showKeyBoard, object: nil, queue: nil) { (Notification) in
         print(Notification.self)
         print("Aparece el teclado")
        
        }
        
    nc.addObserver(forName: closeKeyBoard, object: nil, queue: nil) { (Notification) in
            print(Notification.self)
            print("Desaparece el teclado")
        }
        
        
   
        
    }
    
    func stopObserving(){
        
       let nc = NotificationCenter.default
    
       nc.removeObserver(self)
        
        
    }
    
    
    
}



//MARK: - Util habilita el TAP para quitar el keyboard

extension NoteViewController{
    
    func tapCloseKeyboard() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(NoteViewController.closeKeyBoard))
        view.addGestureRecognizer(tap)
        
    }
    
    func closeKeyBoard(){
        
        view.endEditing(true)
    }
    
}

//MARK: - Habilita el intro del keyboard


extension NoteViewController:UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
         view.endEditing(true)
         return true
    }
    
    
    
}


