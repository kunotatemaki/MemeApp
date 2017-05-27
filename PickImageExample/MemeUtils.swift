//
//  MemeUtils.swift
//  MemeApp
//
//  Created by Raúl Feliz Alonso on 27/5/17.
//  Copyright © 2017 RukiaSoft. All rights reserved.
//

import UIKit
import Foundation

class MemeUtils {
    
    
    
    /*
     * Generate a name for the image, to be used later for persist it
     */
    func getDateTimeAsString() -> String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM_ddd_yyyy_HH:mm:ss"
        let dateStr: String = dateFormatter.string(from: Date())
        return dateStr
    }
    
    
        
}
