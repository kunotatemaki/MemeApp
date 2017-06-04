//
//  ViewController.swift
//  PickImageExample
//
//  Created by Raúl Feliz Alonso on 24/5/17.
//  Copyright © 2017 RukiaSoft. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    
    
    @IBOutlet weak var bottomToolbar: UIToolbar!

    var pickerDelegate: ImagePickerDelegate!
    var topTextDelegate: TopTextFieldDelegate!
    var bottomTextDelegate: BottomTextFieldDelegate!
    var shareScreen:UIImage!
    
    let TOP_MESSAGE = "TOP"
    let BOTTOM_MESSAGE = "BOTTOM"
    var meme: Meme?
    
    let memeTextAttributes:[String:Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "Impact", size: 40)!,
        NSStrokeWidthAttributeName: NSNumber(value: -3.0 as Float)]
    
    
    enum SenderType: Int {
        case libraryTag = 0, cameraTag, topTextTag, bottomTextTag
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        checkShareButtom()
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        pickerDelegate = ImagePickerDelegate(view: imageView, controller: self)
        topTextDelegate = TopTextFieldDelegate(controller: self)
        bottomTextDelegate = BottomTextFieldDelegate(screenView: view, controller: self)
        
        topText.delegate = topTextDelegate
        bottomText.delegate = bottomTextDelegate
        setToolbarHidden(false)
        if let meme = meme{
            setupTextField(topText, withText: meme.textTop)
            setupTextField(bottomText, withText: meme.textBottom)
        }else{
            setupTextField(topText, withText: TOP_MESSAGE)
            setupTextField(bottomText, withText: BOTTOM_MESSAGE)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let meme = meme{
            imageView.image = meme.originalImage
            imageView.contentMode = UIViewContentMode.scaleAspectFit
        }
        checkShareButtom()
    }

    // setup the text fields with the desired properties
    fileprivate func setupTextField(_ field: UITextField, withText text: String!) {
        field.text = text
        field.autocapitalizationType = UITextAutocapitalizationType.allCharacters
        field.defaultTextAttributes = memeTextAttributes
        field.textAlignment = NSTextAlignment.center
    }
    
    @IBAction func pickImage(_ sender: Any) {
        
        guard let button = sender as? UIBarButtonItem else{
            print("not valid sender")
            return
        }
        let pickControler = UIImagePickerController()
        
        switch(SenderType(rawValue: button.tag)!) {
        case .libraryTag:
            pickControler.sourceType = .photoLibrary
        case .cameraTag:
            pickControler.sourceType = .camera
        default:
            print("not valid sender")
        }
        pickControler.delegate = pickerDelegate
        self.present(pickControler, animated: true, completion: nil)
    }
    
    
    @IBAction func cancelMeme(_ sender: Any) {
        
        imageView.image = nil
        let delBottom = bottomText.delegate as! BottomTextFieldDelegate
        delBottom.restoreInitialText(bottomText.self, true)
        let delTop = topText.delegate as! TopTextFieldDelegate
        delTop.restoreInitialText(topText.self, true)
        checkShareButtom()
    }
    
    /*
     * Share button action
     */
    @IBAction func shareAction(_ sender: UIBarButtonItem) {
        shareScreen = generateMemedImage()
        
        let activityViewController = UIActivityViewController(activityItems: [shareScreen], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        present(activityViewController, animated: true, completion: {
            activityViewController.completionWithItemsHandler = { activity, success, items, error in
                
                if !success { print("cancelled")
                    self.save()
                    self.navigationController?.popViewController(animated: true)
                    return
                }
                self.save()
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
    
    
    // when sharing activity completes save meme then dismiss this editor,
    // returning to previous view on navigation stack.
    fileprivate func completeSharingActivity(_ activityType: String!, completed: Bool, returnedItems: [AnyObject]!, activityError: NSError!) {
        if completed {
            save()
        }
    }
    
    // Save the meme, at moment just in memory
    func save() {
        let fileName = MemeUtils().getDateTimeAsString()
        let memeData = Meme(textTop: topText.text!, textBottom: bottomText.text!, originalImage: imageView.image!, memeImage: shareScreen, fileName: fileName)
        
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(memeData)
    }

    
    
    fileprivate func generateMemedImage() -> UIImage {
        
        setToolbarHidden(true)
        
        // Render view to an image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawHierarchy(in: view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        setToolbarHidden(false)
        
        return memedImage
    }
    
    // hide or show the toolbars
    fileprivate func setToolbarHidden(_ isHidden: Bool) {
        bottomToolbar.isHidden = isHidden
    }
    
    fileprivate func canShare() -> Bool{
        return (imageView.image != nil)
    }
    
    func checkShareButtom() {
        shareButton.isEnabled = canShare()
    }
    
   
    
}

