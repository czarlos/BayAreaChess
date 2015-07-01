//
//  TournamentInformation.swift
//  BayAreaChess
//
//  Created by Carlos Reyes on 7/1/15.
//  Copyright (c) 2015 Carlos Reyes. All rights reserved.
//

import UIKit

class TournamentInformation: UIViewController {
    
    var myIndex : Int = Int()
    @IBOutlet var myCaption: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBarHidden = false
        myCaption?.text = String(myIndex)
    }
}