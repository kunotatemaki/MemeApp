//
//  DetailMemeViewCell.swift
//  MemeApp
//
//  Created by Raúl Feliz Alonso on 2/6/17.
//  Copyright © 2017 RukiaSoft. All rights reserved.
//

import UIKit

class DetailMemeViewController: UIViewController {
    
    // MARK: Properties
    
    var meme: Meme!
    
    // MARK: Outlets
    
    @IBOutlet weak var memeView: UIImageView!
    
    
    // MARK: Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.memeView!.image = meme.memeImage
        self.memeView!.contentMode = UIViewContentMode.scaleAspectFit
        
 
        
    }}
