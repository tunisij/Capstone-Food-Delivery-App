//
//  OrdersDetailViewController.swift
//  Capstone
//
//  Created by John Tunisi, Ross Bryan, Ethan Christensen,  Ethan Keel  on 10/22/15.
//  Copyright © 2015 JJohn Tunisi, Ross Bryan, Ethan Christensen,  Ethan Keel . All rights reserved.
//
import UIKit

class OrdersDetailViewController: UIViewController {
    
    var orderHeader: String = "detailTestHeader"
    var orderNumber: Int = -1
    var orderDescription: String = "detailTestDescription"
    
    var detailItem: AnyObject? {
        didSet {
            self.configureView()
        }
    }
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    /**********************************
     *
     *
     **********************************/
    func configureView() {
//        if let detail = self.detailItem as! NSArray? {
//            
//        }
    }
    
    /**********************************
     *
     *
     **********************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        
        if orderHeader != ""{
            headerLabel.text = orderHeader
            numberLabel.text = "\(orderNumber)"
            descriptionLabel.text = orderDescription
            
        }

    }
    
    
    @IBAction func deleteOrderPressed(sender: AnyObject) {
        let alert = UIAlertController(title: "Deleter Order", message: "Are you sure you want to delete your order?", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { (alertAction: UIAlertAction!) -> Void in
            
            print ("you pressed yes")
            //delete order from parse
            //provide feedback
            
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .Default, handler: { (alertAction: UIAlertAction!) -> Void in
            //dont do anything
            print("You pressed no")
            
        }))
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (alertAction: UIAlertAction!) -> Void in
            //still dont do anything
            print("You pressed cancel")
            
        }))
        
        
        
        //necessary for alert box to show
        self.presentViewController(alert, animated: true) { () -> Void in
            
            print("This will run when the alert view is presented to the screen")
            
        }
        

    }
    
    
    
    
    /**********************************
     *
     *
     **********************************/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}