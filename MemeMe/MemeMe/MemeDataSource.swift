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
        guard let cell = tableView.dequeueReusableCellWithIdentifier(ReuseIdentifier.TableViewCell) as? MemeTableViewCell else {
            return UITableViewCell()
        }
        let meme = memes[indexPath.row]
        
        cell.memeView.image = meme.image
        cell.topText.text = meme.topText
        cell.bottomText.text = meme.bottomText
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    // MARK: Swipe to delete
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            memes.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        }
    }
}

// MARK: - CollectionView Protocol Conformance

extension MemeDataSource : UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ReuseIdentifier.CollectionViewCell, forIndexPath: indexPath) as! MemeCollectionViewCell
        let meme = memes[indexPath.row]
        
        cell.image.image = meme.memedImage
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
}
