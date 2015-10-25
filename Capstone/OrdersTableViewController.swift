//
//  OrdersTableViewController.swift
//  Capstone
//
//  Created by Ethan Christensen on 10/12/15.
//  Copyright © 2015 John Tunisi. All rights reserved.
//

import UIKit

class OrdersTableViewController: UITableViewController {
    
    var count: Int = 0
    var detailViewController: OrdersDetailViewController? = nil
    var nextOrder: CustomerOrder = CustomerOrder(name: "TableTestHeader", number: -1, message: "TableTestMessage")
    var orders = [CustomerOrder]()
    var objects = [AnyObject]()


    override func viewDidLoad() {
        super.viewDidLoad()
        insertNewObject(self, index: 0)
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? OrdersDetailViewController
        }
    }


    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCellWithIdentifier("AddNewRowCell", forIndexPath: indexPath)
        } else {
            cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
            let object = objects[indexPath.row] as! NSDate
            cell.textLabel!.text = object.description
        }
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    func insertNewObject(sender: AnyObject, index: Int) {
        objects.insert(NSDate(), atIndex: 0)
        let indexPath = NSIndexPath(forRow: index, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showOrderDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row] as! NSDate
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! OrdersDetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    @IBAction func AddNewRow(sender: UIButton) {
        insertNewObject(self, index: 1)
    }
}
