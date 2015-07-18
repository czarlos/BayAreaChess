//
//  AddressLabel.swift
//  BayAreaChess
//
//  Created by Carlos Reyes on 7/16/15.
//  Copyright (c) 2015 Carlos Reyes. All rights reserved.
//

import UIKit

class AddressLabel : UILabel {
    
    override func drawTextInRect(rect: CGRect) {
        var insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, insets))
    }
}
