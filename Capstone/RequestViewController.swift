//
//  DriverViewController.swift
//  Capstone
//
//  Created by Travis Keel on 11/9/15.
//  Copyright © 2015 John Tunisi. All rights reserved.
//

import UIKit
import Parse

class RequestViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TableViewCellDelegate {


    @IBOutlet weak var tableView: UITableView!

    var requests = [CustomerOrder]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.blackColor()
        tableView.rowHeight = 50
        
        //set to use custom TableViewCell class
        tableView.registerClass(DriverTableViewCell.self, forCellReuseIdentifier: "cell")

        // Do any additional setup after loading the view.
        getOrders()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requests.count
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
                as! DriverTableViewCell
            //cell.textLabel?.backgroundColor = UIColor.clearColor()
            cell.selectionStyle = .None
            let item = requests[indexPath.row]
            //cell.textLabel?.text = item.text
            
            cell.delegate = self
            cell.request = item
            
            return cell
    }
    
    //Removes from list if driver swipes left
    func orderDenied(request: CustomerOrder) {
        let index = (requests as NSArray).indexOfObject(request)
        if index == NSNotFound { return }
        
        // could removeAtIndex in the loop but keep it here for when indexOfObject works
        requests.removeAtIndex(index)
        
        // use the UITableView to animate the removal of this row
        tableView.beginUpdates()
        let indexPathForRow = NSIndexPath(forRow: index, inSection: 0)
        tableView.deleteRowsAtIndexPaths([indexPathForRow], withRowAnimation: .Fade)
        tableView.endUpdates()
    }
    
    // MARK: - Table view delegate
    
    func colorForIndex(index: Int) -> UIColor {
        let itemCount = requests.count - 1
        let val = (CGFloat(index) / CGFloat(itemCount)) * 0.6
        return UIColor(red: 1.0, green: val, blue: 0.0, alpha: 1.0)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell,
        forRowAtIndexPath indexPath: NSIndexPath) {
            cell.backgroundColor = colorForIndex(indexPath.row)
    }
    
    // MARK: - Parse
    
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
                        print(uOrder)
                        self.tableView.reloadData()
                    }
                }
                else {
                    print("Error: \(error!)")
                } }
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
