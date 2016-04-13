//
//  PushUpKeyboardViewController.swift
//  MemeMe
//
//  Created by Joshua Kelley on 4/8/16.
//  Copyright © 2016 Joshua Kelley. All rights reserved.
//

import UIKit

/**
 `PushUpKeyboardViewController` extends `UIViewController` and implements
    - Touch off keyboard dismissal
    - Return Key Dismissal
    - Raising the view when a selected UITextField will be covered by the 
 keyboard so the view is still visible.
 
 In order to get all the push up keyboard functionality, simply extend
 this `PushUpKeyboardViewController` with your VC and make sure that you set the delegate on any
 text fields that you want to have the pushupkeyboard functionality
 equal to self (your VC, that is).
 */
class PushUpKeyboardViewController : UIViewController {
    
    // MARK: - Properties
    
    /// is the keyboard currently raised?
    var keyboardIsRaised = false
    
    /// The keyboard that is being editted now.
    var activeTextField: UITextField?
    
    // MARK: - View Controller Lifecycle
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    // When you touch off the keyboard, dismiss keyboard
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Notification Center
    
    /// Subsribe and listen for the keyboard
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PushUpKeyboardViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PushUpKeyboardViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    /// Unsubscribe from listening for the keyboard
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Raise and Lower Keyboards
    
    /// Called when Will Show Notification occurs 
    func keyboardWillShow(notification: NSNotification) {
        let height = getKeyBoardHeight(notification)
        
        if !keyboardIsRaised  && bottomOfActiveTextField(height) > (view.frame.height - height) {
            self.view.frame.origin.y -= height
            keyboardIsRaised = true
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if keyboardIsRaised {
            self.view.frame.origin.y += getKeyBoardHeight(notification)
            keyboardIsRaised = false
        }
    }
    
    // MARK: - Geometry Methods
    
    func getKeyBoardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        guard let keyboardSize = userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else { // of CGRect
            return 0.0
        }
        return keyboardSize.CGRectValue().height
    }
    
    func bottomOfActiveTextField(keyboardHeight: CGFloat) -> CGFloat {
        guard let textfield = activeTextField else {
            return 0.0
            
        }
        return textfield.frame.origin.y + textfield.frame.size.height
    }
}

// MARK: - Specific UITextFieldDelegate Methods

extension PushUpKeyboardViewController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(textField: UITextField) {
        activeTextField = textField
    }
    
    // Be able to dismiss keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
