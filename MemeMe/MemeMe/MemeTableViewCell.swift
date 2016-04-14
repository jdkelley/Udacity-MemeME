//
//  MemeTableViewCell.swift
//  MemeMe
//
//  Created by Joshua Kelley on 4/14/16.
//  Copyright © 2016 Joshua Kelley. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {
    
//    @IBOutlet weak var memeImage: UIImageView!
//    @IBOutlet weak var label: UILabel!

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.frame.size = CGSizeMake(100, 80)
    }
    

}
