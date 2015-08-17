//
//  TournamentsViewController.swift
//  BayAreaChess
//
//  Created by Carlos Reyes on 4/30/15.
//  Copyright (c) 2015 Carlos Reyes. All rights reserved.
//

import UIKit
import SwiftHTTP
import SwiftyJSON

class TournamentsViewController : UITableViewController {
    
    var dateList = [String]()
    var eventList = [String]()
    var items = ["foo", "bar", "baz"]
    var TIDList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.hidesBarsOnSwipe = true
        self.refreshControl?.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidLoad()
        getTournaments()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = false
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let item: AnyObject = self.eventList[indexPath.row]
        
        var cell : TournamentTableViewCell = tableView.dequeueReusableCellWithIdentifier(Constants.Identifier.TournamentCell, forIndexPath: indexPath) as! TournamentTableViewCell
        cell.configure((item as? String)!, date: self.dateList[indexPath.row], imageName: Constants.Image.ProfileBackground)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return Constants.Cell.TournamentCellSize
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println(indexPath.row)
        self.performSegueWithIdentifier(Constants.Segue.SpecificTournament, sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == Constants.Segue.SpecificTournament) {
            let viewController : TournamentInformation = segue.destinationViewController as! TournamentInformation
            let indexPath = self.tableView.indexPathForSelectedRow()
            viewController.myIndex = indexPath!.row
            viewController.myTID = self.TIDList[indexPath!.row]
            viewController.myEventName = self.eventList[indexPath!.row]
            viewController.myDate = self.dateList[indexPath!.row]
        }
    }
    
    func getTournaments() {
        var request = HTTPTask()
        request.GET(Constants.URL.GENERAL_TOURNAMENTS, parameters: nil, completionHandler: {(response: HTTPResponse) in
            if let data = response.responseObject as? NSData {
                dispatch_async(dispatch_get_main_queue()) {
                    let json = JSON(data: data)
                    self.eventList = self.getEventArray(json)
                    self.dateList = self.getDateArray(json)
                    self.TIDList = self.getTIDArray(json)
                    self.tableView.reloadData()
                }
            }
            })
    }
    
    func getDateArray(json: JSON) -> [String] {
        var dateArray : [String] = []
        for i in json.arrayValue {
            var item = i[Constants.Key.Start][Constants.Key.DateTime]
            var formatter: NSDateFormatter = NSDateFormatter()
            formatter.dateFormat = Constants.Date.GoogleCalendarFormat
            var date : NSDate = NSDate()
            
            if (item.string == nil) {
                dateArray.append("N/A")
                continue
            }
            else if (formatter.dateFromString(item.string!) != nil) {
                date = formatter.dateFromString(item.string!)!
            }
            else {
                formatter.dateFormat = Constants.Date.ReverseStandard
                date = formatter.dateFromString(item.string!)!
            }
            formatter.dateFormat = Constants.Date.Standard
            let stringDate: String = formatter.stringFromDate(date)
            dateArray.append(stringDate);
        }
        return dateArray
    }
    
    func getEventArray(json: JSON) -> [String] {
        var events : [String] = []
        for item in json.arrayValue {
            events.append((item[Constants.Key.Summary]).string!)
        }
        return events
    }
    
    func getTIDArray(json: JSON) -> [String] {
        var TIDs : [String] = []
        for item in json.arrayValue {
            TIDs.append((item[Constants.Key.ID]).string!)
        }
        return TIDs
    }
    
    func refresh(sender: AnyObject) {
        getTournaments()
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
}
