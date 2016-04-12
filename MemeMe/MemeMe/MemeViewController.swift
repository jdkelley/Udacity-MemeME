//
//  MemeViewController.swift
//  MemeMe
//
//  Created by Joshua Kelley on 3/29/16.
//  Copyright © 2016 Joshua Kelley. All rights reserved.
//

import UIKit

class MemeViewController: PushUpKeyboardViewController {
    
    // MARK: - Properties
    
    /// This object handles taking a picture.
    var camera = MemeCamera()
    
    /// List of saved memes. I am assuming we will do something with 
    /// saved memes in the version 2.0
    var savedMemes = [Meme]()
    
    /// The working meme. (For now this is where the meme is saved while
    /// you are sharing it and before it is saved)
    var meme: Meme?
    
    // Textfields
    @IBOutlet weak var topMemeText: UITextField!
    @IBOutlet weak var bottomMemeText: UITextField!
    
    // buttons
    @IBOutlet weak var cancelEditButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    // bars
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var navBar: UINavigationBar!
    
    // image view
    @IBOutlet weak var imageView: UIImageView!

    // MARK: - View Controller Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set delegates
        bottomMemeText.delegate = self
        topMemeText.delegate = self
        
        // Setup Camera
        camera.setupWith(self)
        camera.imageView = imageView
        
        // Set initial UI State
        setInitialUIState()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setShareUI()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    // MARK: - Actions
    
    @IBAction func pickImageFromCamera(sender: AnyObject) {
        camera.pick(.Camera)
    }
    
    @IBAction func pickImageFromAlbum(sender: AnyObject) {
        camera.pick(.PhotoLibrary)
    }
    
    @IBAction func shareMeme(sender: AnyObject) {
        let memedImage = generateMemedImage()
        meme = Meme(topText: topMemeText.text ?? "", bottomText: bottomMemeText.text ?? "", image: imageView.image!, memedImage: memedImage)
        shareNewMeme(memedImage)
    }
    
    @IBAction func cancelEdit(sender: AnyObject) {
        setInitialUIState()
    }
    
    // MARK: - Custom Methods
    
    /// Save meme to array of memes and set working meme to nil
    func saveMeme() {
        (UIApplication.sharedApplication().delegate as! AppDelegate).memes.append(meme!)
        meme = nil
    }
    
    /// Share the image passed in via Apple's Native social share view controller
    /// - parameter image: the image to share
    func shareNewMeme(image: UIImage) {
        
        let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        activityVC.completionWithItemsHandler = { activity, success, items, error in
            if success {
                self.saveMeme()
                self.setShareUI()
            }
        }
        
        self.presentViewController(activityVC, animated: true, completion: nil)
        
    }
    
    /**
     Takes the current meme image and text, renders it to an image and passes that image back.
     - returns: a rendered meme. ( `UIImage`)
     */
    func generateMemedImage() -> UIImage {
        
        // Hide toolbgar and navbar
        setToolBarsVisible(false)
        
        // render view to an image
        UIGraphicsBeginImageContext(imageView.frame.size)
        view.drawViewHierarchyInRect(imageView.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Show toolbar and navbar
        setToolBarsVisible(true)
        return memedImage
    }
}

// MARK: - UI
extension MemeViewController {
    
    // MARK: SETUP
    
    func setShareUI() {
        shareButton.enabled = (imageView.image != nil) // Enable Share Button?
    }
    
    /// Set the initial UIState of the MemeEditor Screen.
    private func setInitialUIState() {
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)
        setupTextFields()
        imageView.image = nil
    }

    /// Set up the meme textfields to their initial state
    private func setupTextFields() {
        // set default text
        topMemeText.text = DefaultText.TopTextFieldText
        bottomMemeText.text = DefaultText.BottomTextFieldText
        
        // set textfield attributes
        setTextFieldAttributes(topMemeText, bottomMemeText)
    }
    
    /// Takes a list of textfields and sets the attributes on them for memes
    /// - parameter textfields: a list of textfields
    private func setTextFieldAttributes(textfields : UITextField ... ) {
        // textfield attributes
        let memeMeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor()/* TODO: Fill in Appropriate UIColor */,
            NSForegroundColorAttributeName : UIColor.whiteColor()/* TODO: Fill in appropriate UIColor */,
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : 0.0/* TODO: Fill in appropriate float */
        ]
    
        for textfield in textfields {
            textfield.defaultTextAttributes = memeMeTextAttributes
            textfield.textAlignment = NSTextAlignment.Center
        }
    }
    
    /// This methods sets the toolbars as visible or not based on the parameter `visible`
    /// - parameter visible: Set the toolbars visible?
    private func setToolBarsVisible(visible: Bool) {
        toolbar.alpha = visible ? 1.0 : 0.0
        navBar.alpha = visible ? 1.0 : 0.0
    }
}
