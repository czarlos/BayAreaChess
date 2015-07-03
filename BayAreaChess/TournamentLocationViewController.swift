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

    let initialLocation = CLLocation(latitude: 37.71, longitude: -122.42)
    
    let regionRadius: CLLocationDistance = 15000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centerOnPlacemark(myLocation)
//        centerMapOnLocation(initialLocation)
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
//        var address = "1 Infinite Loop, CA, USA"
        var geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks: [AnyObject]!, error: NSError!) -> Void in
            if let placemark = placemarks?[0] as? CLPlacemark {
                
                let location = placemark.location
//                var coord : CLLocation = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                
                let coordinates = MKCoordinateRegionMakeWithDistance(location.coordinate, self.regionRadius * 2.0, self.regionRadius * 2.0)
                
                self.mapView.setRegion(coordinates, animated: true)
                

            }
        })
    }
}