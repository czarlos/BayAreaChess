//
//  TournamentsViewController.swift
//  BayAreaChess
//
//  Created by Carlos Reyes on 4/30/15.
//  Copyright (c) 2015 Carlos Reyes. All rights reserved.
//

import UIKit
import SwiftHTTP

class TournamentsViewController : UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidLoad()
        getTournaments()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func getTournaments() {
        var request = HTTPTask()
        request.GET("http://bac.colab.duke.edu:3000/api/v1/tournaments/general", parameters: nil, success: {(response: HTTPResponse) in
            if let data = response.responseObject as? NSData {
                let str = NSString(data: data, encoding: NSUTF8StringEncoding)
                println(str) //prints the HTML of the page
            }
            },failure: {(error: NSError, response: HTTPResponse?) in
                println("error: \(error)")
        })
    }
}
