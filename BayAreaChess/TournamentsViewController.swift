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
    var dateList = [String]()
    let SUMMARY = "summary"

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
        return self.eventList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let item: AnyObject = self.eventList[indexPath.row]
        var cell = tableView.dequeueReusableCellWithIdentifier(Constants.Identifier.UI_TABLE_VIEW_CELL, forIndexPath: indexPath) as! UITableViewCell
        cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: Constants.Identifier.UI_TABLE_VIEW_CELL);
        
        cell.textLabel!.text = item as? String
        cell.detailTextLabel?.text = self.dateList[indexPath.row]
        return cell
    }
    
    func getTournaments() {
        var request = HTTPTask()
        request.GET(Constants.URL.GENERAL_TOURNAMENTS, parameters: nil, success: {(response: HTTPResponse) in
            if let data = response.responseObject as? NSData {
                dispatch_async(dispatch_get_main_queue()) {
                    let json = JSON(data: data)
                    self.eventList = self.getEventArray(json)
                    self.dateList = self.getDateArray(json)
                    self.tableView.reloadData()
                }
            }
            },failure: {(error: NSError, response: HTTPResponse?) in
                println("error: \(error)")
        })
    }
    
    func getDateArray(json: JSON) -> [String] {
        var dateArray : [String] = []
        for i in json.arrayValue {
            var item = i["start"]["dateTime"]
            var formatter: NSDateFormatter = NSDateFormatter();
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssSSSZZZZ";
            var date : NSDate = NSDate();
            
            if (item.string == nil) {
                dateArray.append("N/A")
                continue
            }
            else if (formatter.dateFromString(item.string!) != nil) {
                date = formatter.dateFromString(item.string!)!
            }
            else {
                formatter.dateFormat = "yyyy-MM-dd"
                date = formatter.dateFromString(item.string!)!;
            }
            formatter.dateFormat = "MM-dd-yyyy ";
            let stringDate: String = formatter.stringFromDate(date);
            dateArray.append(stringDate);
        }
        return dateArray
    }
    
    func getEventArray(json: JSON) -> [String] {
        var events : [String] = []
        for item in json.arrayValue {
            events.append((item[SUMMARY]).string!)
        }
        return events
    }
}
