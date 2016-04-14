//
//  MemesTableViewController.swift
//  MemeMe
//
//  Created by Joshua Kelley on 4/12/16.
//  Copyright © 2016 Joshua Kelley. All rights reserved.
//

import UIKit

class MemesTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var memes: [Meme] {
        return MemeDataSource.sharedInstance.memes
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = MemeDataSource.sharedInstance

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate

extension MemesTableViewController : UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let vc = storyboard?.instantiateViewControllerWithIdentifier(Storyboard.ID.DisplayMemeViewController) as? DisplayMemeViewController {
            vc.setMeme(memes[indexPath.row])
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
