//
//  TournamentLocationViewController.swift
//  BayAreaChess
//
//  Created by Carlos Reyes on 7/2/15.
//  Copyright (c) 2015 Carlos Reyes. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class TournamentLocationViewController : UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var myLocation : String = String()
    var myEventName : String = String()

    let sanFrancisco = CLLocation(latitude: 37.71, longitude: -122.42)
    
    let regionRadius: CLLocationDistance = 15000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        centerOnPlacemark(myLocation)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.hidden = true
    }
    
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
}