//
//  TournamentTableViewCell.swift
//  BayAreaChess
//
//  Created by Carlos Reyes on 7/14/15.
//  Copyright (c) 2015 Carlos Reyes. All rights reserved.
//

import UIKit

class TournamentTableViewCell : UITableViewCell {
    @IBOutlet var myImage : UIImageView!
    @IBOutlet var myTournamentName : UILabel!
    @IBOutlet var myDate : UILabel!
    @IBOutlet var myStar : UIButton!
    
    internal func configure(text: String, date: String, imageName: String) {
        myTournamentName.text = text
        myDate.text = date
        myImage.image = UIImage(named: imageName)
    }
}
