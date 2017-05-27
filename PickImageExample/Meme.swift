//
//  Meme.swift
//  MemeMe v1.0
//
//  Created by Raúl Feliz Alonso on 24/5/17.
//  Copyright © 2017 RukiaSoft. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Meme {
    
    var textTop: String!
     var textBottom: String!
     var originalImage: UIImage!
     var memeImage: UIImage!
    var fileName: String!
    
    
    
    init(top: String, bottom: String, original: UIImage, memed: UIImage, path: String) {
        
        textTop = top
        textBottom = bottom
        originalImage = original
        memeImage = memed
        fileName = path
    }
}
