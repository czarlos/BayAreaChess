//
//  ProfileTableViewCell.swift
//  BayAreaChess
//
//  Created by Carlos Reyes on 7/15/15.
//  Copyright (c) 2015 Carlos Reyes. All rights reserved.
//

import UIKit

class ProfileTableViewCell : UITableViewCell {
    
    @IBOutlet var myLogoutButton : UIButton!
    @IBOutlet var myName : UILabel!
    @IBOutlet var myProfileImageView : UIImageView!
    @IBOutlet var mySubtitleName: UILabel!
    
    override func awakeFromNib() {
        myProfileImageView.layer.borderColor = UIColor.whiteColor().CGColor
        myProfileImageView.layer.borderWidth = 2.0
    }
    
    func configure(name : String, subtitleName: String, imageName : String) {
        myName.text = name
        mySubtitleName.text = subtitleName
        myProfileImageView.image = UIImage(named: imageName)
    }

}
