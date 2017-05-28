//
//  TopTextFieldDelegate.swift
//  MemeMe v1.0
//
//  Created by Raúl Feliz on 26/5/2017.
//  Copyright (c) 2017 Udacity. All rights reserved.
//

import Foundation
import UIKit

class TopTextFieldDelegate: TextFieldDelegate {
    
    // default values for the text fields
    

    init(controller: MemeViewController!) {
        super.init(controller: controller, text: "TOP")
    }
    
        
}
