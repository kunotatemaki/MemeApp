//
//  CollectionMemeViewController.swift
//  MemeApp
//
//  Created by Raúl Feliz Alonso on 1/6/17.
//  Copyright © 2017 RukiaSoft. All rights reserved.
//

import UIKit

class CollectionMemeViewController: UICollectionViewController, SharedModelProtocol {

    @IBOutlet weak var bottomBar: UITabBarItem!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView!.reloadData()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.hidesBottomBarWhenPushed = false
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
                let meme = getMemes()[indexPath.row]
        
        // Set the name and image
        cell.memeImageView?.image = meme.memeImage
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "DetailMemeViewController") as! DetailMemeViewController
        detailController.meme = getMemes()[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }

    func getMemes() -> [Meme] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.memes
    }

}
