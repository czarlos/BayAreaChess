//
//  TournamentLocationAnnotation.swift
//  BayAreaChess
//
//  Created by Carlos Reyes on 7/5/15.
//  Copyright (c) 2015 Carlos Reyes. All rights reserved.
//

import UIKit
import MapKit

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
    
    var subtitle: String {
        return locationName
    }
}
