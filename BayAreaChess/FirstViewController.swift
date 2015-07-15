//
//  FirstViewController.swift
//  BayAreaChess
//
//  Created by Carlos Reyes on 4/8/15.
//  Copyright (c) 2015 Carlos Reyes. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize.height = 1000
        navigationController?.hidesBarsOnSwipe = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.hidden = false
    }
    
    @IBAction func logout (sender: UIButton) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey("carlos")
        self.performSegueWithIdentifier("logout", sender: self)
    }
}