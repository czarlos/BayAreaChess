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
import MapKit
import CoreLocation

class TournamentInformation: UIViewController {
    
    @IBOutlet var myLocationButton : UIButton?
    @IBOutlet var myTournamentNameLabel : UILabel?
    @IBOutlet var myDateLabel : UILabel?
    @IBOutlet var myDescriptionTextView : UITextView?
    
    var myIndex : Int = Int()
    var myTID : String = String()
    var myEventName : String = String()
    var myRegistrationLink : String = String()
    @IBOutlet var myCaption: UILabel?
    let LOCATION = "location"
    
    @IBOutlet weak var mapView: MKMapView!
    var myLocation : String = String()
    var myLocationManager : CLLocationManager = CLLocationManager()
    let sanFrancisco = CLLocation(latitude: 37.71, longitude: -122.42)
    let regionRadius: CLLocationDistance = 15000
    
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
        mapView.delegate = self
        navigationController?.hidesBarsOnTap = true
        myTournamentNameLabel?.text = myEventName
//        centerOnPlacemark(myLocation)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        checkLocationAuthorizationStatus()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.hidden = true
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.hidesBarsOnTap = false
        myCaption?.text = String(myIndex)
        self.mapView.zoomEnabled = false
        self.mapView.scrollEnabled = false
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if (segue.identifier == "tournamentLocation") {
//            let vc : TournamentLocationViewController = segue.destinationViewController as! TournamentLocationViewController
//            vc.myLocation = self.location
//            vc.myEventName = self.myEventName
//        }
//    }
    
    func getTournamentData(tid: String) {
        var request = HTTPTask()
        request.GET(Constants.URL.GENERAL_TOURNAMENTS + "/" + tid, parameters: nil, success: {(response: HTTPResponse) in
            if let data = response.responseObject as? NSData {
                dispatch_async(dispatch_get_main_queue()) {
                    let json = JSON(data: data)
                    self.loadJSON(json)
                    self.centerOnPlacemark(self.myLocation)
//                    println(json)
//                    self.location = self.getLocation(json)
//                    self.myLocation!.text = self.location
//                    self.getDescription(json)
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
    
    func toDictionary(array: Array<String>) -> Dictionary<String, String> {
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
    
    func loadJSON(json: JSON) {
        self.myLocation = self.getLocation(json)
        self.myLocationButton?.setTitle(self.myLocation, forState: UIControlState.Disabled)
        self.myDescriptionTextView?.text = self.getDescription(json)
    }
    
    //Maps support
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func centerOnPlacemark(address: String) {
        var geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks: [AnyObject]!, error: NSError!) -> Void in
            if let placemark = placemarks?[0] as? CLPlacemark {
                
                let location = placemark.location
                let coordinates = MKCoordinateRegionMakeWithDistance(location.coordinate, self.regionRadius * 2.0, self.regionRadius * 2.0)
                
                self.addEventAnnotation(coordinates, eventName: self.myEventName, city: placemark.addressDictionary["City"] as! String)
                self.mapView.setRegion(coordinates, animated: true)
                
            }
            else {
                self.centerMapOnLocation(self.sanFrancisco)
            }
        })
    }
    
    func addEventAnnotation (coordinate: MKCoordinateRegion, eventName: String, city: String) {
        let eventAnnotation : TournamentLocationAnnotation = TournamentLocationAnnotation(title: eventName, locationName: city, discipline: "Sculpture", coordinate: CLLocationCoordinate2D(latitude: coordinate.center.latitude, longitude: coordinate.center.longitude))
        
        mapView.addAnnotation(eventAnnotation)
    }
    
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            myLocationManager.requestWhenInUseAuthorization()
        }
    }
    
}