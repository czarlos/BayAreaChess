//
//  LoginViewController.swift
//  BayAreaChess
//
//  Created by Carlos Reyes on 4/8/15.
//  Copyright (c) 2015 Carlos Reyes. All rights reserved.
//

import UIKit

let userNameKeyConstant = "carlos"

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if (checkCredentials()) {
//            self.performSegueWithIdentifier("login", sender: self)
//        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBarHidden = false
    }
    
    @IBAction func login(sender: UIButton) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject("password", forKey: userNameKeyConstant)
        self.performSegueWithIdentifier("login", sender: self)
    }
    
    func checkCredentials() -> Bool {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let name = defaults.stringForKey(userNameKeyConstant) {
            return true
        }
        return false
    }
    
    @IBAction func goBack (sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

