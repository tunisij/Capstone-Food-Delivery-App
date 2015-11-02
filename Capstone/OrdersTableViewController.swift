//
//  OrdersTableViewController.swift
//  Capstone
//
//  Created by John Tunisi, Ross Bryan, Ethan Christensen,  Ethan Keel  on 10/22/15.
//  Copyright © 2015 JJohn Tunisi, Ross Bryan, Ethan Christensen,  Ethan Keel . All rights reserved.
//


import UIKit
import Parse
import MMDrawerController

class OrdersTableViewController: UITableViewController {
    
    var count: Int = 0
    var detailViewController: OrdersDetailViewController? = nil
    var nextOrder: CustomerOrder = CustomerOrder(name: "TableTestHeader", number: -1, message: "TableTestMessage")
    var orderList = [CustomerOrder]()
    var refreshController = UIRefreshControl()
    
    /**********************************
     *
     *
     **********************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        insertNewObject(self, index: 0)
        self.refreshControl = refreshController
        self.refreshControl?.addTarget(self, action: "didRefresh", forControlEvents: .ValueChanged)
 
        getOrders()
        //        if let split = self.splitViewController {
        //            let controllers = split.viewControllers
        //            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? OrdersDetailViewController
        //        }
    }
    
    /**********************************
     *
     *
     **********************************/
    func didRefresh() {
        self.refreshControl?.beginRefreshing()
        orderList.removeAll()
        getOrders()
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    /**********************************
     *
     *
     **********************************/
    func getOrders(){
        let query = PFQuery(className: "Order")
        query.whereKeyExists("OrderHeader")
        query.addDescendingOrder("createdAt")
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) in
            if error == nil {
                let pfobjects = objects
                if objects != nil {
                for object in pfobjects! {
                    let uOrder = object["OrderHeader"] as! String
                    let uDesc = object["OrderDescription"] as! String
                    let uNum: Int = 1 //object["OrderNumber"] as! Int
                    self.orderList.append(CustomerOrder(name: uOrder, number: uNum, message: uDesc))
                    print(uOrder)
                    self.tableView.reloadData()
                }
            }
            else {
                print("Error: \(error!)")
                } }
            
        }
    }
    
    /**********************************
     *
     *
     **********************************/
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    /**********************************
     *
     *
     **********************************/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    /**********************************
    *
    *
    **********************************/
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    /**********************************
     *
     *
     **********************************/
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderList.count+1
    }
    
    /**********************************
     *
     *
     **********************************/
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        let statusImage: UIImage = UIImage(named: "redstatus.png")!
        
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCellWithIdentifier("AddNewRowCell", forIndexPath: indexPath)
        } else {
            let cell2: OrdersTableCell
            cell2 = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! OrdersTableCell
            let object = orderList[indexPath.row-1]
            cell2.orderHeaderLabel.text = object.orderName
          //  print ("Image loaded1 \(statusImage)")
            cell2.orderStatusImage.image = statusImage
            return cell2
        }
        return cell
    }
    
    /**********************************
     *
     *
     **********************************/
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    /**********************************
     *
     *
     **********************************/
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            orderList.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    /**********************************
     *
     *
     **********************************/
    func insertNewObject(sender: AnyObject, index: Int) {
        //   orderList.insert(, atIndex: 0)
        _ = (forRow: index, inSection: 0)
        //      self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
    
    /**********************************
     *
     *
     **********************************/
     //alert box method
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        
        let alert = UIAlertController(title: "Order Information", message: "You have tapped accessory for\n The current status of your order is: + orderStatus (something to be completed)", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    /**********************************
     *
     *
     **********************************/
     // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showOrderDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                let object = orderList[indexPath.row]
                let controller = segue.destinationViewController as! OrdersDetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
                controller.orderHeader = object.orderName
                controller.orderDescription = object.orderMessage
                controller.orderNumber = object.orderNumber
            }
        }
    }
    
    /**********************************
     *
     *
     **********************************/
    @IBAction func AddNewRow(sender: UIButton) {
        insertNewObject(self, index: 0)
    }
    
    /**********************************
     *
     *
     **********************************/
    @IBAction func drawerMenuClicked(sender: UIBarButtonItem) {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
    
    /*
    func retrievePlaces() {
    let query = PFQuery(className: parseOrderClass)
    query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) in
    if error == nil {
    let pfobjects = objects as! [PFObject]
    for object in pfobjects {
    let place = object[self.placeColumnKey] as! String
    let vote = object[self.voteColumnKey] as! Int
    if !self.eateries.contains(place) {
    self.eateries.append(place)
    self.votes.append(vote)
    self.updateTableView()
    }
    }
    } else {
    print("Error: \(error!)")
    }
    }
    */
}



















