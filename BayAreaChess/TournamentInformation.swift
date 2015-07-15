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
    var myEventName : String = String()
    var myRegistrationLink : String = String()
    @IBOutlet var myCaption: UILabel?
    let LOCATION = "location"
    
    struct Event {
        let info : String?
        let flyer : String?
        let registration : String?
        let entries : String?
        let contact : String?
    }
    
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
        self.tabBarController?.tabBar.hidden = false
        self.navigationController?.navigationBarHidden = false
        myCaption?.text = String(myIndex)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "tournamentLocation") {
            let vc : TournamentLocationViewController = segue.destinationViewController as! TournamentLocationViewController
            vc.myLocation = self.location
            vc.myEventName = self.myEventName
        }
    }
    
    func getTournamentData(tid: String) {
        var request = HTTPTask()
        request.GET(Constants.URL.GENERAL_TOURNAMENTS + "/" + tid, parameters: nil, success: {(response: HTTPResponse) in
            if let data = response.responseObject as? NSData {
                dispatch_async(dispatch_get_main_queue()) {
                    let json = JSON(data: data)
//                    println(json)
                    self.location = self.getLocation(json)
                    self.myLocation!.text = self.location
                    self.getDescription(json)
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
    
    func getDescription(json: JSON) -> String {
        var description : String? = json["description"].string
        
        var m = description?.componentsSeparatedByString("\n")
        //println(m)
        var c = toDictionary(m!)
        
        self.myRegistrationLink = (c["REGISTER"] != nil ? c["REGISTER"]! : "http://bayareachess.com/mtype/")
        
        return description != nil ? description! : ""
    }
    
    func toDictionary(array : Array<String>) -> Dictionary<String, String> {
        var dict : Dictionary<String, String> = Dictionary()
        
        for item in array {
            var obj = item.componentsSeparatedByString(": ")
            //println(obj)
            if (obj.count > 1) {
                dict[obj[0]] = obj[1]
            }
        }
        
        return dict
    }
}