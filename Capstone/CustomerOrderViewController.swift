//
//  CustomerOrderViewController.swift
//  Capstone
//
//  Created by Ross Bryan on 10/22/15.
//  Copyright © 2015 John Tunisi. All rights reserved.
//

import Foundation
import UIKit

class CustomerOrderViewController:  UIViewController {
    @IBOutlet weak var orderTypeSwitch: UISwitch!
    
    @IBOutlet weak var orderTypeLabel: UILabel!
    
    @IBAction func CustomerOrderTypeSwitch(sender: AnyObject) {
        
        if orderTypeSwitch.on {
            orderTypeLabel.text = "Fast Food"
         //   orderTypeSwitch.setOn(false, animated: true)
        }
        else {
            orderTypeLabel.text = "Groceries"
     //       orderTypeSwitch.setOn(true, animated: true)
            
        }
        
        
    }
    
    
    
    override func viewDidLoad() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    
    
}