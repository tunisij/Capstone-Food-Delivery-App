//
//  CustomerOrderViewController.swift
//  Capstone
//
//  Created by John Tunisi, Ross Bryan, Ethan Christensen,  Ethan Keel  on 10/22/15.
//  Copyright © 2015 JJohn Tunisi, Ross Bryan, Ethan Christensen,  Ethan Keel . All rights reserved.
//
import Foundation
import UIKit
import Parse

class CustomerOrderViewController:  UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //DB Key
    let classNameKey: String = "Order"
    let numberNameKey: String = "OrderNumberClass"
    //Orders DB Key for order number
    let orderNumberColumnKey: String = "orderNumber"
    let orderNameKey: String = "OrderHeader"
    let orderDescriptionKey: String = "OrderDescription"
    
    //Text Field for User Input Order Header
    @IBOutlet weak var headerField: UITextField!
    //Text Field for User Input Order Description
    @IBOutlet weak var descriptionField: UITextView!
    //Text Field for User order street address
    @IBOutlet weak var adressField: UITextField!
    //Text Field for User ORder city
    @IBOutlet weak var cityField: UITextField!
    //Text Field for user order zip code
    @IBOutlet weak var zipField: UITextField!
    //String that will combine the above 3 to provide 1 return into the Parse database
    //  let orderLocation: String
    
    var orderType: String = ""
 
    //Order Type Picker View
    @IBOutlet weak var picker: UIPickerView!
    //Picker View Data
    var pickerData: [String] = [String]()
    
    //picker view set up
    // The number of columns of data
    /**********************************
    *
    *
    **********************************/
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    /**********************************
    *
    *
    **********************************/
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    /**********************************
    *
    *
    **********************************/
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if row == 0 {
            orderType = "Fast Food"
        }
        
        if row == 1 {
            orderType = "Pick Up"
        }
        
        if row == 2 {
            orderType = "Groceries"
        }
        
        return pickerData[row]
    }
    
    /**********************************
     *
     *
     **********************************/
    func displayOrderFeedbackPrompt(){
        let simpleAlert = UIAlertController(title: "Ordered Succesfully Placed", message: "Your order has been succesfully placed and will now be viewable for drivers to accept. ", preferredStyle: .Alert)
        simpleAlert.addAction(UIAlertAction(title:"Ok", style: .Default, handler: nil))
        self.presentViewController(simpleAlert, animated: true, completion: nil)
        
    }
    
    /**********************************
     *
     *
     **********************************/
    func validOrder() -> Bool {
        
        if (headerField.text == "" || descriptionField.text == ""){
            let simpleAlert = UIAlertController(title: "Order Save Error", message: "All fields are mandatory. ", preferredStyle: .Alert)
            simpleAlert.addAction(UIAlertAction(title:"Ok", style: .Default, handler: nil))
            self.presentViewController(simpleAlert, animated: true, completion: nil)
            return false;
        }
        return true
        
    }
    
    /**********************************
     * SAVES order into the database
     *
     **********************************/
    var myDebugCounter: Int = 0
    @IBAction func orderCompleteButton(sender: AnyObject) {
        //Confirm that all forms are filled out
        if !validOrder(){
            return
        }
        let oHead: String = headerField.text!
        let oDesc: String = descriptionField.text
        var orNum: String = ""
        //SAVE INTO DATABASE
        //insert user order into parse database
        let insertOrder = PFObject(className: classNameKey)
        insertOrder[orderNameKey] = oHead
        insertOrder[orderDescriptionKey] = oDesc
        insertOrder["orderType"] = orderType
        // insertOrder["OrderNumber"] = oNum
        insertOrder["orderStatus"] = 0 //order created, not yet assigned
        //  insertOrder["orderCreator"] = user.username
        //check on save into database
        do {
            
            try insertOrder.save()
            orNum = insertOrder.objectId!
            insertOrder["orderNumber"] = orNum
                      do {
                try insertOrder.save()
                displayOrderFeedbackPrompt()
                        print(orNum)

            }
        
        }
        catch _ {
            print ("fuck this shit didnt work")
        }
        headerField.text = ""
        headerField.placeholder = "Order Title"
        descriptionField.text = "Enter order information here."
        
    }
    
    
    /**********************************
     *
     *
     **********************************/
    override func viewDidLoad() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        // Connect data:
        self.picker.delegate = self
        self.picker.dataSource = self
        // Input data into the Array:
        pickerData = ["Fast Food","Pick Up", "Groceries"]
    }
    
    /**********************************
     *
     *
     **********************************/
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    /**********************************
     *
     *
     **********************************/
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    
    
    
    
    
    
}