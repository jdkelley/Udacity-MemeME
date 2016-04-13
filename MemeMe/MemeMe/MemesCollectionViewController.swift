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
        return MemeDataSource.sharedInstance.memes
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.delegate = self
        collectionView?.dataSource = MemeDataSource.sharedInstance
        
        setupCollectionFlow()
    }
    
    private func setupCollectionFlow() {
        
        // TODO: User both width and height
        
        let space: CGFloat = 3.0
        let dimension = (self.view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
        
    }
    
}

// MARK: - UICollectionViewDelegate

extension MemesCollectionViewController : UICollectionViewDelegateFlowLayout {
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let vc = storyboard?.instantiateViewControllerWithIdentifier(Storyboard.ID.DisplayMemeViewController) as! DisplayMemeViewController
        vc.imageView.image = memes[indexPath.row].memedImage
        navigationController?.pushViewController(vc, animated: true)
    }
}
