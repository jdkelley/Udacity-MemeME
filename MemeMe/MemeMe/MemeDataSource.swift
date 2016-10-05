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
    
    fileprivate override init() {
        super.init()
    }
    
    // MARK: - Properties
    
    var memes = [Meme]()
    
    func saveMeme(_ meme: Meme) {
        memes.append(meme)
    }
}

// MARK: - TableView Protocol Conformance

extension MemeDataSource : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.TableViewCell) as? MemeTableViewCell else {
            return UITableViewCell()
        }
        let meme = memes[(indexPath as NSIndexPath).row]
        
        cell.memeView.image = meme.image
        cell.topText.text = meme.topText
        cell.bottomText.text = meme.bottomText
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    // MARK: Swipe to delete
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            memes.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
}

// MARK: - CollectionView Protocol Conformance

extension MemeDataSource : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.CollectionViewCell, for: indexPath) as! MemeCollectionViewCell
        let meme = memes[(indexPath as NSIndexPath).row]
        
        cell.image.image = meme.memedImage
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
}
