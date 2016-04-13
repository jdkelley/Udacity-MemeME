//
//  MemesTableViewController.swift
//  MemeMe
//
//  Created by Joshua Kelley on 4/12/16.
//  Copyright © 2016 Joshua Kelley. All rights reserved.
//

import UIKit

class MemesTableViewController: UIViewController {
    
    var memes: [Meme] {
        return MemeDataSource.sharedInstance.memes
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

// MARK: - UITableViewDelegate

extension MemesTableViewController : UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = storyboard?.instantiateViewControllerWithIdentifier(Storyboard.IDs.DisplayMeme) as! DisplayMemeViewController
        vc.imageView.image = memes[indexPath.row].memedImage
        navigationController?.pushViewController(vc, animated: true)
    }
}
