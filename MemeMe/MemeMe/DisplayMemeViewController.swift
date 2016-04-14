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
    
    func editSelected() {
        if let editor = storyboard?.instantiateViewControllerWithIdentifier(Storyboard.ID.MemeEditorViewController) as? MemeEditorViewController {
            editor.meme = meme
            navigationController?.pushViewController(editor, animated: true)
        }
    }
}
