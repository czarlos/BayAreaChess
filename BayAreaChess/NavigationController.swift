//
//  NavigationController.swift
//  BayAreaChess
//
//  Created by Carlos Reyes on 4/9/15.
//  Copyright (c) 2015 Carlos Reyes. All rights reserved.
//

import UIKit

class NavigationController : UINavigationController {
    override func viewDidLoad() {
        
//        let font = UIFont.systemFontOfSize(13)
//        let textDictionary = [NSFontAttributeName: font, NSForegroundColorAttributeName:UIColor.whiteColor()] as Dictionary
//        UIBarButtonItem.appearance().setTitleTextAttributes(textDictionary, forState: UIControlState.Normal)
        
        let swiftColor = UIColor(red: 34/255, green: 104/255, blue: 158/255, alpha: 0.5)
        UINavigationBar.appearance().barTintColor = swiftColor
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func back(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
