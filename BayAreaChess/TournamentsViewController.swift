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
    var items = ["foo", "bar", "baz"]
    var eventList = [String]()
    let SUMMARY = "summary"
    let GENERAL_TOURNAMENTS_URL = "http://bac.colab.duke.edu:3000/api/v1/tournaments/general"
    let UI_TABLE_VIEW_CELL = "UITableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        getTournaments()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.items.count
        return self.eventList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let item = self.items[indexPath.row]
        let item: AnyObject = self.eventList[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(UI_TABLE_VIEW_CELL, forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel!.text = item as? String
        return cell
    }
    
    func getTournaments() {
        var request = HTTPTask()
        request.GET(GENERAL_TOURNAMENTS_URL, parameters: nil, success: {(response: HTTPResponse) in
            if let data = response.responseObject as? NSData {
                dispatch_async(dispatch_get_main_queue()) {
                    let json = JSON(data: data)
                    self.eventList = self.getEventArray(json)
                    self.tableView.reloadData()
                }
            }
            },failure: {(error: NSError, response: HTTPResponse?) in
                println("error: \(error)")
        })
    }
    
    func getEventArray(json: JSON) -> [String] {
        var events : [String] = []
        for item in json.arrayValue {
            events.append((item[SUMMARY]).string!)
        }
        return events
    }
}
