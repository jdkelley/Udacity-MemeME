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


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        memeTextFieldDelegate = MemeTextFieldDelegate(top: topMemeText, bottom: bottomMemeText)
    }
    
    @IBAction func pickImageFromCamera(sender: AnyObject) {
        
    }
    
    @IBAction func pickImageFromAlbum(sender: AnyObject) {
        
    }
    
    @IBAction func shareMeme(sender: AnyObject) {
        
    }
    
    @IBAction func cancelEdit(sender: AnyObject) {
        
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

 
}

// MARK: - UI
extension MemeViewController {
    
    // MARK: SETUP
    
    private func setupButtons() {
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
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

//extension MemeViewController : UITextFieldDelegate {
//    
//    // Clear Default Placeholder Text
//    func textFieldDidBeginEditing(textField: UITextField) {
//        guard let text = textField.text else {
//            return
//        }
//        if textField == topMemeText && text == DefaultText.TopTextFieldText {
//            textField.text = ""
//        } else  if textField == bottomMemeText && text == DefaultText.BottomTextFieldText {
//            textField.text = ""
//        }
//    }
//    
//    // Be able to dismiss keyboard
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
//    
//    
//}

//import UIKit.UITextField

class MemeTextFieldDelegate : NSObject , UITextFieldDelegate {
    
    var top: UITextField
    var bottom: UITextField
    
    init(top: UITextField, bottom: UITextField) {
        self.top = top
        self.bottom = bottom
        
        super.init()
        
        bottom.delegate = self
        top.delegate = self
    }
    
    // Clear Default Placeholder Text
    func textFieldDidBeginEditing(textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        if textField == top && text == DefaultText.TopTextFieldText {
            textField.text = ""
        } else  if textField == bottom && text == DefaultText.BottomTextFieldText {
            textField.text = ""
        }
    }
    
    // Be able to dismiss keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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

extension MemeViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
}
