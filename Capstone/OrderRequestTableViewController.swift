//
//  OrderRequestTableViewController.swift
//  Capstone
//
//  Created by Travis Keel on 11/2/15.
//  Copyright © 2015 John Tunisi. All rights reserved.
//

import UIKit
import Parse

class OrderRequestTableViewController: UITableViewController {
    
    var orderList = [CustomerOrder]()
    var refreshController = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl = refreshController
        self.refreshControl?.addTarget(self, action: "didRefresh", forControlEvents: .ValueChanged)
        
        getOrders()

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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderList.count
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    /**********************************
    *
    *
    **********************************/
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
      
        cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let object = orderList[indexPath.row]
        cell.textLabel!.text = object.orderName
        
        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

    
    
    /**********************************
    *
    *
    **********************************/
    func getOrders(){
        let query = PFQuery(className: "Order")
        query.whereKeyExists("OrderHeader")
        
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) in
            if error == nil {
                let pfobjects = objects
                if objects != nil {
                    for object in pfobjects! {
                        let uOrder = object["OrderHeader"] as! String
                        let uDesc = object["OrderDescription"] as! String
                        let uNum: String = object["orderNumber"] as! String
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
    func insertNewObject(sender: AnyObject, index: Int) {

        _ = (forRow: index, inSection: 0)

    }

}
