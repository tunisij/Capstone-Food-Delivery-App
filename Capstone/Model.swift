//
//  Model.swift
//  Capstone
//
//  Created by John Tunisi, Ross Bryan, Ethan Christensen,  Ethan Keel  on 10/22/15.
//  Copyright © 2015 JJohn Tunisi, Ross Bryan, Ethan Christensen,  Ethan Keel . All rights reserved.
//

import CoreLocation

class Model {
    var userOrder: CustomerOrder
    let locationManager = CLLocationManager()
    
    init(order: CustomerOrder){
        userOrder = order
    }
    
    init(){
        userOrder = CustomerOrder(name: "a", number: 1, message: "a")
    }
    
    
}