//
//  RegistrationViewController.swift
//  BayAreaChess
//
//  Created by Carlos Reyes on 7/2/15.
//  Copyright (c) 2015 Carlos Reyes. All rights reserved.
//

import UIKit

class RegistrationViewController : UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    let url = "http://bayareachess.com/static/pdf/champs15.pdf"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let requestURL = NSURL(string:url)
        let request = NSURLRequest(URL: requestURL!)
        webView.loadRequest(request)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.hidden = true
    }
}
