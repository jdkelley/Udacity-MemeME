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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.reloadData()
    }
}

// MARK: - Flow Layout

extension MemesCollectionViewController : UICollectionViewDelegateFlowLayout{
    
    fileprivate func setupCollectionFlow(_ size: CGSize) {
        
        // This is to fix a bug.
        // Sometimes when on tableview and turn landscape
        // and haven't visited collection view yet, flowLayout
        // will still be nil for some reason. This guard statement fixes it
        guard flowLayout != nil else {
            return
        }
        
        let space: CGFloat = 3.0
        let dimension = (min(size.width,size.width) - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        setupCollectionFlow(size)
    }
}

// MARK: - UICollectionViewDelegate

extension MemesCollectionViewController {

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: Storyboard.ID.DisplayMemeViewController) as? DisplayMemeViewController {
            vc.setMeme(memes[(indexPath as NSIndexPath).row])
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
