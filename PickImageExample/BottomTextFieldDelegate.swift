//
//  BottomTextFieldDelegate.swift
//  MemeMe v1.0
//
//  Created by Raúl Feliz on 26/5/2017.
//  Copyright (c) 2017 Udacity. All rights reserved.
//

import Foundation
import UIKit

class BottomTextFieldDelegate: NSObject, UITextFieldDelegate, TextFieldProtocol{
    
    // default values for the text field
    let bottomText = "BOTTOM"
    let controller: MemeViewController!

    let container: UIView!
    
    init(screenView: UIView!, controller: MemeViewController!) {
        container = screenView
        self.controller = controller
    }
    
    // verify if the textfield have the defaul text when the
    // user start to edit
    func textFieldDidBeginEditing(_ textField: UITextField) {
        subscribeToKeyboardNotification()
        
        var currentText = textField.text
        
        if currentText == bottomText {
            currentText = ""
        }
        
        textField.text = currentText
    }
    
    // dismiss the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        unsubscribeFromKeyboardNotification()
        
        restoreInitialText(textField, false)
        
        return true
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
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        restoreInitialText(textField, false)
    }
    
    func restoreInitialText(_ textField: UITextField, _ force: Bool){
        if textField.text == "" || force == true {
            textField.text = bottomText
        }
        controller.checkShareButtom()

    }
    
    func isInInitialState(_ text: String) -> Bool{
        return text.isEqual(bottomText)
    }
}
