//
//  AddNewDeliveryLocationViewController.swift
//  Capstone
//
//  Created by John Tunisi on 11/6/15.
//  Copyright © 2015 John Tunisi. All rights reserved.
//

import Parse

class AddNewDeliveryLocationViewController: UIViewController, UIPickerViewDelegate {
    
    @IBOutlet weak var locationNickame: UITextField!
    @IBOutlet weak var streetAddress: UITextField!
    @IBOutlet weak var zipCode: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var statePickerView: UIPickerView!
    
    var selectedState: String = ""
    
    let states = ["Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "District of Columbia", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statePickerView.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return states.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return states[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedState = states[row]
    }
    
    @IBAction func saveLocation(sender: UIButton) {
        let deliveryLocation = PFObject(className:"DeliveryLocation")
        deliveryLocation["LocationCoordinates"] = nil
        deliveryLocation["Address"] = streetAddress.text
        deliveryLocation["City"] = city.text
        deliveryLocation["ZipCode"] = zipCode.text
        deliveryLocation["State"] = selectedState
        deliveryLocation.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                let didNotSaveAlert = UIAlertController(title: "Error Saving", message: "Something went wrong processing your order. Please try again.", preferredStyle: .Alert)
                didNotSaveAlert.addAction(UIAlertAction(title:"Ok", style: .Default, handler: nil))
                self.presentViewController(didNotSaveAlert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func dismissViewController(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}