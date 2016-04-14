//
//  TabBarViewController.swift
//  MemeMe
//
//  Created by Joshua Kelley on 4/13/16.
//  Copyright © 2016 Joshua Kelley. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if MemeDataSource.sharedInstance.memes.count < 1 {
            newMeme(self)
        }
    }

    @IBAction func newMeme(sender: AnyObject) {
        if let editor = storyboard?.instantiateViewControllerWithIdentifier(Storyboard.ID.MemeEditorViewController) as? MemeEditorViewController {
            presentViewController(editor, animated: true, completion: nil)
        }
    }
    
}
