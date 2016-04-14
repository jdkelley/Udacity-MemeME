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
        
        setupCollectionFlow(view.frame.size)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.reloadData()
    }
}

// MARK: - Flow Layout

extension MemesCollectionViewController : UICollectionViewDelegateFlowLayout{
    
    private func setupCollectionFlow(size: CGSize) {
        
        // TODO: User both width and height
        
        let space: CGFloat = 3.0
        let dimension = (min(size.width,size.width) - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
        
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        setupCollectionFlow(size)
    }
}

// MARK: - UICollectionViewDelegate

extension MemesCollectionViewController {
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let vc = storyboard?.instantiateViewControllerWithIdentifier(Storyboard.ID.DisplayMemeViewController) as? DisplayMemeViewController {
            vc.setMeme(memes[indexPath.row])
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
