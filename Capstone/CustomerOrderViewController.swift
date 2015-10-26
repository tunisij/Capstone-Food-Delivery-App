//
//  CustomerOrderViewController.swift
//  Capstone
//
//  Created by John Tunisi, Ross Bryan, Ethan Christensen,  Ethan Keel  on 10/22/15.
//  Copyright © 2015 JJohn Tunisi, Ross Bryan, Ethan Christensen,  Ethan Keel . All rights reserved.
//
import Foundation
import UIKit

class CustomerOrderViewController:  UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    @IBOutlet weak var orderTypeLabel: UILabel!
    
    var userOrder: CustomerOrder!
    
    @IBOutlet weak var headerField: UITextField!
    
    @IBOutlet weak var descriptionField: UITextView!
    
    var createdYet: Bool = false
    var type: Bool = true
    
    
    @IBOutlet weak var picker: UIPickerView!
     var pickerData: [String] = [String]()
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    
    @IBAction func orderCompleteButton(sender: AnyObject) {
        print(createdYet)
        let oHead: String = headerField.text!
        let oNum: Int = 1
        let oDesc: String = descriptionField.text
        
        userOrder = CustomerOrder(name: oHead, number: oNum, message: oDesc)
        createdYet = true
        print(userOrder.orderMessage)
        
    }
    
    
    
    override func viewDidLoad() {
        createdYet = false
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
        // Connect data:
        self.picker.delegate = self
        self.picker.dataSource = self
        
        // Input data into the Array:
        pickerData = ["Pick Up", "Fast Food", "Groceries"]

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "customerOrder"{
            let vc = segue.destinationViewController as! OrdersTableViewController
            if createdYet{
                vc.nextOrder = userOrder
                print(vc.nextOrder.orderMessage)
            }
            
        }
        //viewController.nextOrder = userOrder
        
    }
    


    
    
}