//
//  FirstViewController.swift
//  BayAreaChess
//
//  Created by Carlos Reyes on 4/8/15.
//  Copyright (c) 2015 Carlos Reyes. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBarHidden = true
    }
    
    @IBAction func logout (sender: UIButton) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey("carlos")
        self.performSegueWithIdentifier("logout", sender: self)
    }
}