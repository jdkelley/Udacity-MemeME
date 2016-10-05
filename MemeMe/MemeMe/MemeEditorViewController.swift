//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by Joshua Kelley on 3/29/16.
//  Copyright © 2016 Joshua Kelley. All rights reserved.
//

import UIKit

class MemeEditorViewController: PushUpKeyboardViewController {
    
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
    
    // bar
    @IBOutlet weak var toolbar: UIToolbar!
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setShareUI()
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    // MARK: - Actions
    
    @IBAction func pickImageFromCamera(_ sender: AnyObject) {
        camera.pick(.camera)
    }
    
    @IBAction func pickImageFromAlbum(_ sender: AnyObject) {
        camera.pick(.photoLibrary)
    }
    
    @IBAction func shareMeme(_ sender: AnyObject) {
        meme = Meme(topText: topMemeText.text ?? "", bottomText: bottomMemeText.text ?? "", image: imageView.image!, memedImage: generateMemedImage())
        shareNewMeme(meme!)
    }
    
    @IBAction func cancelEdit(_ sender: AnyObject) {
        setInitialUIState()
        navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - Custom Methods
    
    /// Share the meme image passed in via Apple's Native social share view controller
    /// - parameter meme: the meme to share
    func shareNewMeme(_ meme: Meme) {
        
        let activityVC = UIActivityViewController(activityItems: [meme.memedImage], applicationActivities: nil)
        
        activityVC.completionWithItemsHandler = { activity, success, items, error in
            if success {
                MemeDataSource.sharedInstance.saveMeme(meme)
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
        self.present(activityVC, animated: true, completion: nil)
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
        view.drawHierarchy(in: imageView.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Show toolbar and navbar
        setToolBarsVisible(true)
        return memedImage
    }
}

// MARK: - UI : Private because only this View Controller should be able to edit its views
extension MemeEditorViewController {
    
    fileprivate func setShareUI() {
        shareButton.isEnabled = (imageView.image != nil) // Enable Share Button?
    }
    
    /// Set the initial UIState of the MemeEditor Screen.
    fileprivate func setInitialUIState() {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        setupTextFields()
        imageView.image = meme?.image
    }

    /// Set up the meme textfields to their initial state
    fileprivate func setupTextFields() {
        // set default text
        topMemeText.text = meme?.topText ?? DefaultText.TopTextFieldText
        bottomMemeText.text = meme?.bottomText ?? DefaultText.BottomTextFieldText
        
        // set textfield attributes
        setTextFieldAttributes(topMemeText, bottomMemeText)
    }
    
    /// Takes a list of textfields and sets the attributes on them for memes
    /// - parameter textfields: a list of textfields
    fileprivate func setTextFieldAttributes(_ textfields : UITextField ... ) {
        // textfield attributes
        let memeMeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.black,
            NSForegroundColorAttributeName : UIColor.white,
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : -2.0
        ] as [String : Any]
    
        for textfield in textfields {
            textfield.defaultTextAttributes = memeMeTextAttributes
            textfield.textAlignment = NSTextAlignment.center
        }
    }
    
    /// This methods sets the toolbars as visible or not based on the parameter `visible`
    /// - parameter visible: Set the toolbars visible?
    fileprivate func setToolBarsVisible(_ visible: Bool) {
        let transparent: CGFloat = visible ? 1.0 : 0.0
        toolbar.alpha = transparent
        navigationController?.navigationBar.alpha = transparent
    }
}
