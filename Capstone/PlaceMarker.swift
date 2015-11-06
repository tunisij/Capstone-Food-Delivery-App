//
//  PlaceMarker.swift
//  Capstone
//
//  Created by Ethan Christensen on 11/5/15.
//  Copyright © 2015 John Tunisi. All rights reserved.
//

import UIKit
import CoreLocation
import Foundation
import GoogleMaps

class PlaceMarker: GMSMarker {

    let place: Place
    
    init(place: Place) {
        self.place = place
        super.init()
        
        position = place.coordinate
        //icon = UIImage(named: place.placeType+"_pin")
        groundAnchor = CGPoint(x: 0.5, y: 1)
        //appearAnimation = kGMSMarkerAnimationPop
    }
}