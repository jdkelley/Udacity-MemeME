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
    
    
}

extension MemeDataSource : UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        return
    }
    
}

extension MemeDataSource : UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
}

extension MemeDataSource : UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        return
    }
    
}

extension MemeDataSource : UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
}
