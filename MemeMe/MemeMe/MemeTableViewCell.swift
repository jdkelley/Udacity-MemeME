//
//  MemeTableViewCell.swift
//  MemeMe
//
//  Created by Joshua Kelley on 4/14/16.
//  Copyright © 2016 Joshua Kelley. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {
    
    // Labels
    @IBOutlet weak var topText: UILabel!
    @IBOutlet weak var bottomText: UILabel!
    
    // Image View
    @IBOutlet weak var memeView: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        memeView.frame.size = CGSizeMake(100, 80)
    }
}
