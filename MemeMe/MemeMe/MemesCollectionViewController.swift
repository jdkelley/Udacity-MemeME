//
//  MemesCollectionViewController.swift
//  MemeMe
//
//  Created by Joshua Kelley on 4/12/16.
//  Copyright © 2016 Joshua Kelley. All rights reserved.
//

import UIKit

class MemesCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme] {
        guard let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate else {
            return [Meme]()
        }
        return appDelegate.memes
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
