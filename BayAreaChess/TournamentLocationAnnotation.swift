//
//  TournamentLocationAnnotation.swift
//  BayAreaChess
//
//  Created by Carlos Reyes on 7/5/15.
//  Copyright (c) 2015 Carlos Reyes. All rights reserved.
//

import UIKit
import MapKit
import AddressBook

class TournamentLocationAnnotation: NSObject, MKAnnotation {
    let title: String
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    func mapItem() -> MKMapItem {
        let addressDictionary = [String(kABPersonAddressStreetKey): subtitle]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        
        return mapItem
    }
    
    func pinColor() -> MKPinAnnotationColor {
        return .Green
    }
    
    var subtitle: String {
        return locationName
    }
}
