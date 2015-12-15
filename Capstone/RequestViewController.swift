//
//  DriverViewController.swift
//  Capstone
//
//  Created by Travis Keel on 11/9/15.
//  Copyright © 2015 John Tunisi. All rights reserved.
//

import UIKit
import Parse

class RequestViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var tableView: UITableView!

    var requests = [CustomerOrder]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorColor = UIColor.clearColor()
        tableView.rowHeight = 50
    }
    
    override func viewDidAppear(animated: Bool) {
        getOrders()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requests.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellFrame = CGRectMake(0, 0, self.tableView.frame.width, 50.0)
        
        var cell = UITableViewCell(frame: cellFrame)
        cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let item = requests[indexPath.row]
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor(red: 203/255, green: 239/255, blue: 255/255, alpha: 1.0)
        } else {
            cell.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        }
        
        let textLabel = UILabel(frame: CGRectMake(10.0, 0.0, UIScreen.mainScreen().bounds.width - 20.0, 50.0 - 4.0))
        textLabel.textColor = UIColor.blackColor()
        textLabel.text = item.orderName
        cell.addSubview(textLabel)
        return cell
    }
    
    //TEST
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let more = UITableViewRowAction(style: .Normal, title: "More") { action, index in
        }
        more.backgroundColor = UIColor.lightGrayColor()
        
        let accept = UITableViewRowAction(style: .Normal, title: "Accept") { action, index in
            let row = indexPath.row
            let item = self.requests[row]
            self.orderAccepted(item)
        }
        accept.backgroundColor = UIColor.greenColor()
        
        let deny = UITableViewRowAction(style: .Normal, title: "Deny") { action, index in
            let row = indexPath.row
            let item = self.requests[row]
            self.orderRemoved(item)
        }
        deny.backgroundColor = UIColor.redColor()
        
        return [deny, accept, more]
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    
     func getOrders(){
        requests.removeAll()
        
        let query = PFQuery(className: "Order")
        query.whereKeyExists("OrderHeader")
        
        //Only get orders which haven't been accepted
        query.whereKey("orderStatus", equalTo: 0)
        
        query.addDescendingOrder("createdAt")
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) in
            if error == nil {
                let pfobjects = objects
                if objects != nil {
                    for object in pfobjects! {
                        let uOrder = object["OrderHeader"] as! String
                        let uDesc = object["OrderDescription"] as! String
                        let uNum: String = object["orderNumber"] as! String
                        self.requests.append(CustomerOrder(name: uOrder, number: uNum, message: uDesc))
                        self.tableView.reloadData()
                    }
                }
                else {

                } }
        }
    }
    
    func orderRemoved(order: CustomerOrder) {
        let index = (requests as NSArray).indexOfObject(order)
        if index == NSNotFound { return }
        
        // could removeAtIndex in the loop but keep it here for when indexOfObject works
        requests.removeAtIndex(index)
        
        // use the UITableView to animate the removal of this row
        tableView.beginUpdates()
        let indexPathForRow = NSIndexPath(forRow: index, inSection: 0)
        tableView.deleteRowsAtIndexPaths([indexPathForRow], withRowAnimation: .Fade)
        tableView.endUpdates()
    }
    
    func orderAccepted(order: CustomerOrder) {
        let index = (requests as NSArray).indexOfObject(order)
        if index == NSNotFound { return }
        
        let orderID = requests[index].orderNumber
        let query = PFQuery(className: "Order")
        
        query.getObjectInBackgroundWithId(orderID){
            (accepted: PFObject?, error: NSError?) -> Void in
            if error != nil {
            } else if let accepted = accepted {
                accepted.incrementKey("orderStatus")
                accepted.saveInBackground()
                self.orderRemoved(order)
            }
        }
    }

}
