//
//  TopTextFieldDelegate.swift
//  MemeMe v1.0
//
//  Created by Raúl Feliz on 26/5/2017.
//  Copyright (c) 2017 Udacity. All rights reserved.
//

import Foundation
import UIKit

class TextFieldDelegate: NSObject, UITextFieldDelegate, TextFieldProtocol {
    
    // default values for the text fields
    let defaultText: String?
    let controller: MemeViewController!

    init(controller: MemeViewController!, text: String!) {
        self.controller = controller
        defaultText = text
    }
    
    // verify if the textfield have the defaul text when the
    // user start to edit
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        var currentText = textField.text
        
        if currentText == defaultText {
            currentText = ""
        }
        
        textField.text = currentText
        
    }
    
    // dismiss the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        restoreInitialText(textField, false)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        restoreInitialText(textField, false)
    }
    
    func restoreInitialText(_ textField: UITextField, _ force: Bool){
        if textField.text == "" || force == true {
            textField.text = defaultText
        }
        controller.checkShareButtom()

    }
    
    func isInInitialState(_ text: String) -> Bool{
        return text.isEqual(defaultText)
    }
    
}
