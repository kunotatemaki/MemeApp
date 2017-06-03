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
    
    func setMemes(_ memes: [Meme]) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes = memes
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            handleDeleteMeme(indexPath as NSIndexPath)
        }
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    func handleDeleteMeme(_ posicion: NSIndexPath!) -> Void {
        tableView.beginUpdates()
        var memes: [Meme]!
        memes = getMemes()
        memes.remove(at: posicion.row)
        setMemes(memes)
        tableView.deleteRows(at: [posicion as IndexPath], with: .automatic)
        tableView.endUpdates()
    }
    
}
