//
//  TournamentInformation.swift
//  BayAreaChess
//
//  Created by Carlos Reyes on 7/1/15.
//  Copyright (c) 2015 Carlos Reyes. All rights reserved.
//

import UIKit
import SwiftHTTP
import AddressBook

class TournamentInformation: UIViewController {
    
    var location : String = String()
    @IBOutlet var myLocation : UILabel?
    var myIndex : Int = Int()
    var myTID : String = String()
    @IBOutlet var myCaption: UILabel?
    let LOCATION = "location"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getTournamentData(myTID)
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "tournamentLocation") {
            let vc : TournamentLocationViewController = segue.destinationViewController as! TournamentLocationViewController
            vc.myLocation = self.location
        }
    }
    
    func getTournamentData(tid: String) {
        var request = HTTPTask()
        request.GET(Constants.URL.GENERAL_TOURNAMENTS + "/" + tid, parameters: nil, success: {(response: HTTPResponse) in
            if let data = response.responseObject as? NSData {
                dispatch_async(dispatch_get_main_queue()) {
                    let json = JSON(data: data)
                    self.location = self.getLocation(json)
                    self.myLocation!.text = self.location
                    //println(json)
//                    self.eventList = self.getEventArray(json)
//                    self.dateList = self.getDateArray(json)
//                    self.tableView.reloadData()
                }
            }
            },failure: {(error: NSError, response: HTTPResponse?) in
                println("error: \(error)")
        })
    }
    
    func getLocation(json: JSON) -> String {
        var location : String? = json[LOCATION].string
        return location != nil ? location! : ""
        
    }
}