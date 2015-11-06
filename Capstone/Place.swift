//
//  Place.swift
//  Capstone
//
//  Created by Ethan Christensen on 11/5/15.
//  Copyright © 2015 John Tunisi. All rights reserved.
//

import UIKit

class Place{
    var name: String = ""
    var address: String = ""
    var placeid: String = ""
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(0, 0)
    var lat: Double = 0
    var lng: Double = 0
    
    init(result: AnyObject?){
        if let object = result as? Dictionary<String, AnyObject> {
            
            address = (object["vicinity"] as? String)!
            
            print(address)
            name = (object["name"] as? String)!
            placeid = (object["place_id"] as? String)!
            
            
            if let geo = object["geometry"] as? Dictionary<String, AnyObject> {
                if let loc = geo["location"] as? Dictionary<String, AnyObject> {
                    lat = (loc["lat"] as? Double)!
                    lng = (loc["lng"] as? Double)!
                    coordinate = CLLocationCoordinate2DMake(lat, lng)
                    
                }
            }
        }
    }
    
}
