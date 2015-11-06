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
    let orderNumber: String;
    var orderMessage: String;
    var orderStatus: Int
    //var orderType: String
    
    /*
    Order Status Key:
    0: Order created - no driver assigned
    1: Driver has accepted order, but driver is not doing order
    2: Driver is now doing the order
    3: Order complete - pending delivery
    4: Order en route
    5: Order delivered / Complete
    */
    
    
    /**********************************
    *
    *
    **********************************/
    init(name: String, number: String, message: String) {
        orderName = name;
        orderNumber = number;
        orderMessage = message;
        orderStatus = 0 
    }
    
    func setStatus(status: Int){
        orderStatus = status
    }
    
    
    func printData(){
        print("Order name: \(orderName)\nOrder number: \(orderNumber)\nOrder Message: \(orderMessage)\nOrder Status: \(orderStatus)")
    }
    
    
}