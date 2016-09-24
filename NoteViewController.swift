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
        
//         _bookTag?.book?.=;UIImageJPEGRepresentation(info[UIImagePickerControllerOriginalImage] as! UIImage, 0.9)  as! NSData
        
        
        let image = UIImageJPEGRepresentation((info[UIImagePickerControllerOriginalImage] as! UIImage?)!, 0.9)
        
        let nota = Annotations(title: "NOTAAAA", image: image! as Data, inContext: (_bookTag?.managedObjectContext)!)
        
        _bookTag?.book?.addToAnnotations(nota)
        
        // Quitamos de enmedio al picker
        self.dismiss(animated: true) {
            //
        }

    }
    
    
}


