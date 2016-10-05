//
//  TabBarViewController.swift
//  MemeMe
//
//  Created by Joshua Kelley on 4/13/16.
//  Copyright © 2016 Joshua Kelley. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    /*
     * Note to self: uncomment this to activate the more desirable user experience of going straight to the editor when there are no
     * memes yet saved.
     */
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        if MemeDataSource.sharedInstance.memes.count < 1 {
//            newMeme(self)
//        }
//    }

    @IBAction func newMeme(_ sender: AnyObject) {
        if let editor = storyboard?.instantiateViewController(withIdentifier: Storyboard.ID.MemeEditorViewController) as? MemeEditorViewController {
            navigationController?.pushViewController(editor, animated: true)
        }
    }
}
