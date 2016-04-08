//
//  MemeCamera.swift
//  MemeMe
//
//  Created by Joshua Kelley on 4/8/16.
//  Copyright © 2016 Joshua Kelley. All rights reserved.
//

import UIKit

class MemeCamera : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imageView: UIImageView?
    
    func setup(vc: UIViewController) {
        vc.addChildViewController(self)
    }
    
    func pick(source: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = source
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView?.image = image
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
}
