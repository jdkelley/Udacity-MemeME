//
//  MemeTextFieldDelegate.swift
//  MemeMe
//
//  Created by Joshua Kelley on 4/8/16.
//  Copyright © 2016 Joshua Kelley. All rights reserved.
//

import UIKit

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
