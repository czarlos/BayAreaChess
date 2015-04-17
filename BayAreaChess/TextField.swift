//
//  TextField.swift
//  BayAreaChess
//
//  Created by Carlos Reyes on 4/9/15.
//  Copyright (c) 2015 Carlos Reyes. All rights reserved.
//

import UIKit

class TextField : UITextField {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        var border = CALayer()
        var width = CGFloat(1.0)
        border.borderColor = UIColor(red: 232/255, green: 232/255, blue: 232/255, alpha: 1).CGColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}