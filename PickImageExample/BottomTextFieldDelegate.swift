//
//  BottomTextFieldDelegate.swift
//  MemeMe v1.0
//
//  Created by Raúl Feliz on 26/5/2017.
//  Copyright (c) 2017 Udacity. All rights reserved.
//

import Foundation
import UIKit

class BottomTextFieldDelegate: TextFieldDelegate{
    
    // default values for the text field

    let container: UIView!
    
    init(screenView: UIView!, controller: MemeViewController!) {
        container = screenView
        super.init(controller: controller, text: "BOTTOM")
    }
    
    // verify if the textfield have the defaul text when the
    // user start to edit
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        subscribeToKeyboardNotification()
        super.textFieldDidBeginEditing(textField)
    }
    
    // dismiss the keyboard
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let ok = super.textFieldShouldReturn(textField)
        unsubscribeFromKeyboardNotification()
        return ok;
    }
    
    //MARK: keyboard layout functions
    
    // change the size of the view to move up when the keyboard appears
    func keyboardWillShow(_ notification: Notification) {
        container.frame.origin.y = -getKeyboardHeight(notification)
    }
    
    // change the size of the view to move up when the keyboard disappears
    func keyboardWillDismiss(_ notification: Notification) {
        container.frame.origin.y = 0
    }
    
    // get the keyboard hight from the notification
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        
        return keyboardSize.cgRectValue.height
    }
    
    //MARK: notification functions
    
    // add a observer to the notification center so we can discover when the keyboard showed up
    fileprivate func subscribeToKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(BottomTextFieldDelegate.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(BottomTextFieldDelegate.keyboardWillDismiss(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // remove the observer from the notification center
    fileprivate func unsubscribeFromKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
}
