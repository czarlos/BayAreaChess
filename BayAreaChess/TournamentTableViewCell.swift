//
//  TournamentTableViewCell.swift
//  BayAreaChess
//
//  Created by Carlos Reyes on 7/14/15.
//  Copyright (c) 2015 Carlos Reyes. All rights reserved.
//

import UIKit

class TournamentTableViewCell : UITableViewCell {
    
    @IBOutlet var myDate : UILabel!
    @IBOutlet var myImage : UIImageView!
    @IBOutlet var myStar : UIButton!
    @IBOutlet var myTournamentName : UILabel!
    
    internal func configure(text: String, date: String, imageName: String) {
        myTournamentName.text = text
        myDate.text = date
        myImage.image = UIImage(named: imageName)
    }
}
