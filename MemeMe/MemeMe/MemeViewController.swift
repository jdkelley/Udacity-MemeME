//
//  MemeViewController.swift
//  MemeMe
//
//  Created by Joshua Kelley on 3/29/16.
//  Copyright © 2016 Joshua Kelley. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController { //PushUpKeyboardViewController
    
    // MARK: - Properties
    
    var camera = MemeCamera()
    
    var savedMemes = [Meme]()
    
    var meme: Meme?
    
    var editMode = false
    
    var keyboardIsRaised = false
    
    var memeTextFieldDelegate: MemeTextFieldDelegate?
    
    // Textfields
    @IBOutlet weak var topMemeText: UITextField! { didSet {  } }
    @IBOutlet weak var bottomMemeText: UITextField! { didSet {  } }
    
    // buttons
    @IBOutlet weak var cancelEditButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var imageView: UIImageView!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        memeTextFieldDelegate = MemeTextFieldDelegate(top: topMemeText, bottom: bottomMemeText)
        camera.setup(self)
        camera.imageView = imageView
    }
    
    @IBAction func pickImageFromCamera(sender: AnyObject) {
        camera.pick(.Camera)
    }
    
    @IBAction func pickImageFromAlbum(sender: AnyObject) {
        camera.pick(.PhotoLibrary)
    }
    
    @IBAction func shareMeme(sender: AnyObject) {
        shareNewMeme(generateMemedImage())
    }
    
    @IBAction func cancelEdit(sender: AnyObject) {
        print("Cancel Button Pressed")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        setupButtons()
        setupTextFields()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func saveMeme() {
        // create meme
        //let meme = Meme(text: textField.text!, image: imageView.image, memebedImage: memedImage)
        print("Completion of Save Meme")
    }
    
    func shareNewMeme(image: UIImage) {
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        self.presentViewController(controller, animated: true, completion: saveMeme)
    }
    
    
    
    func generateMemedImage() -> UIImage {
        
        // TODO" Hide toolbgar and navbar
        
        // render view to an image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // TODO: Show toolbar and navbar
        
        return memedImage
    }
}

// MARK: - UI
extension MemeViewController {
    
    // MARK: SETUP
    
    private func setupButtons() {
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)
        shareButton.enabled = false
        cancelEditButton.enabled = false
    }
    
    private func setupTextFields() {
        
        // set default text
        topMemeText.text = DefaultText.TopTextFieldText
        bottomMemeText.text = DefaultText.BottomTextFieldText
        
        // set textfield attributes
        setTextFieldAttributes(topMemeText, bottomMemeText)
        
    }
    
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
        }
    }
}

extension MemeViewController {
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MemeViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MemeViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Custom Methods
    
    func keyboardWillShow(notification: NSNotification) {
        if !keyboardIsRaised {
            self.view.frame.origin.y -= getKeyBoardHeight(notification) //
            keyboardIsRaised = true
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if keyboardIsRaised {
            self.view.frame.origin.y += getKeyBoardHeight(notification)
            keyboardIsRaised = false
        }
    }
    
    func getKeyBoardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        guard let keyboardSize = userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else { // of CGRect
            return 0.0
        }
        return keyboardSize.CGRectValue().height
    }
}
