//
//  ImagePickerDelegate.swift
//  MemeMe v1.0
//
//  Created by Raúl Feliz on 26/5/2017.
//  Copyright (c) 2017 Udacity. All rights reserved.
//

import Foundation
import UIKit

class ImagePickerDelegate: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imageHolder: UIImageView!
    let controller: MemeViewController!
    
    init(view: UIImageView!, controller: MemeViewController!) {
        imageHolder = view
        self.controller = controller
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //print("image selected")
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            imageHolder.image = image
            imageHolder.contentMode = UIViewContentMode.scaleAspectFit
            
        }
        dismiss(picker)
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //print("cancelado")
        dismiss(picker)
        
    }
    
    
    // dismiss the controller
    fileprivate func dismiss(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        controller.checkShareButtom()

    }
}
