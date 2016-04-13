//
//  MemeDataSource.swift
//  MemeMe
//
//  Created by Joshua Kelley on 4/13/16.
//  Copyright © 2016 Joshua Kelley. All rights reserved.
//

import UIKit

class MemeDataSource : NSObject {
    
    // MARK: Singleton
    
    static let sharedInstance = MemeDataSource()
    
    private override init() {
        super.init()
    }
    
    // MARK: - Properties
    
    var memes = [Meme]()
    
    func saveMeme(meme: Meme) {
        memes.append(meme)
    }
    
    
}

// MARK: - TableView Protocol Conformance

extension MemeDataSource : UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
}

// MARK: - CollectionView Protocol Conformance

extension MemeDataSource : UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ReuseIdentifier.CollectionViewCell, forIndexPath: indexPath) as! MemeCollectionViewCell
        let meme = memes[indexPath.row]
        
        cell.image = UIImageView(image: meme.memedImage)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
}
