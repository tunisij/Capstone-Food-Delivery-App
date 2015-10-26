//
//  CustomerOrder.swift
//  Capstone
//
//  Created by John Tunisi, Ross Bryan, Ethan Christensen,  Ethan Keel  on 10/22/15.
//  Copyright © 2015 JJohn Tunisi, Ross Bryan, Ethan Christensen,  Ethan Keel . All rights reserved.
//

import Foundation


class CustomerOrder{
    let orderName: String;
    let orderNumber: Int;
    var orderMessage: String;
    
    
    
    
    init(name: String, number: Int, message: String) {
        orderName = name;
        orderNumber = number;
        orderMessage = message;
    }
    
    
    
    
}