//
//  TableMemeViewController.swift
//  MemeApp
//
//  Created by Raúl Feliz Alonso on 1/6/17.
//  Copyright © 2017 RukiaSoft. All rights reserved.
//

import UIKit

class TableMemeViewController: UITableViewController{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getMemes().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableCell")!
        let meme = getMemes()[indexPath.row]
        
        // Set the name and image
        cell.imageView?.image = meme.originalImage
        cell.textLabel?.text = meme.textTop
        cell.detailTextLabel?.text = meme.textBottom
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "DetailMemeViewController") as! DetailMemeViewController
        detailController.meme = getMemes()[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)

        
    }

    func getMemes() -> [Meme] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.memes
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            }
    
}
