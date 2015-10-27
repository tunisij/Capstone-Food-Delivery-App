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
    
    
    
    //Has the user SAVED the order?
    //by default, no
    var createdYet: Bool = false
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
        return pickerData[row]
    }
    
    
    /**********************************
     * SAVES order into the database
     *
     **********************************/
    @IBAction func orderCompleteButton(sender: AnyObject) {
        //PULL data from the DATABASE
        var query = PFQuery(className:"Orders")
        query.getObjectInBackgroundWithId("xWMyZEGZ") {
            (gameScore: PFObject?, error: NSError?) -> Void in
            if error == nil && gameScore != nil {
                print(gameScore)
            } else {
                print(error)
            }
        }
        //get data from PFObject
        // let score = gameScore["score"] as Int
        let oHead: String = headerField.text!
        let oNum: Int = 1
        let oDesc: String = descriptionField.text
        // let oType: String =
        
        
        //SAVE INTO DATABASE
        //insert user order into parse database
        let insertOrder = PFObject(className:"Order")
        insertOrder["OrderHeader"] = oHead
        insertOrder["OrderDescription"] = oDesc
        //insertOrder["OrderType"] =
        insertOrder["OrderNumber"] = oNum
        
        //check on save into database
        insertOrder.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
                print("Succesful save")
            } else {
                // There was a problem, check error.description
                print("Error saving")
            }
        }
        //set to TRUE because user clicked SAVE button
        createdYet = true
    }
    
    
    /**********************************
     *
     *
     **********************************/
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