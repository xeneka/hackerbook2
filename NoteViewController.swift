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
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var photoImage: UIImageView!

    @IBOutlet weak var textNote: UITextField!
    
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
        
        
        guard  let imagePicker = info[UIImagePickerControllerOriginalImage] as! UIImage? else{
            print("Imagen no Validad")
            return
        }
        
        let image = UIImageJPEGRepresentation(imagePicker, 1)
        
        
        let nota = Annotations(title: "NOTAAAA", image: image! as Data, book: (_bookTag?.book)!, inContext: (_bookTag?.managedObjectContext)!)
        
      
        //_bookTag?.book?.addNote(note: nota, inContext: (_bookTag?.managedObjectContext)!)
      
        // Antes de guardar nota tiene asignado un libro
        try! _bookTag?.managedObjectContext?.save()
        // Despues de guardar no lo tiene
        
        
        // Quitamos de enmedio al picker
        self.dismiss(animated: true) {
            //
        }

    }
    
    
}


