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
    
    /// Setup the Camera (which is a VC) by adding it as a child under the presenting VC.
    func setupWith(_ vc: UIViewController) {
        vc.addChildViewController(self)
    }
    
    /// Pick a picture from `source`.
    func pick(_ source: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = source
        present(imagePicker, animated: true, completion: nil)
    }
    
    /// UIImagePickerControllerDelegate delegate method.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView?.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}
