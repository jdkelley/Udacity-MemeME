//
//  DisplayMemeViewController.swift
//  MemeMe
//
//  Created by Joshua Kelley on 4/13/16.
//  Copyright © 2016 Joshua Kelley. All rights reserved.
//

import UIKit

class DisplayMemeViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    private var meme: Meme?
    
    func setMeme(meme: Meme) {
        self.meme = meme
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .Plain, target: self, action: ActionSelectors.EditSelected)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        imageView.image = meme?.memedImage
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func editSelected() {
        if let editor = storyboard?.instantiateViewControllerWithIdentifier(Storyboard.ID.MemeEditorViewController) as? MemeEditorViewController {
            editor.meme = meme
            navigationController?.presentViewController(editor, animated: true, completion: nil)
        }
    }
}
