//
//  DrawerTableViewController.swift
//  Capstone
//
//  Created by John Tunisi on 10/29/15.
//  Copyright © 2015 John Tunisi. All rights reserved.
//

import UIKit
import MMDrawerController

class DrawerTableViewController: UITableViewController {
    
    let labels = ["Home", "Orders", "Driver", "Settings"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labels.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DrawerCell", forIndexPath: indexPath)
    
        cell.textLabel?.text = labels[indexPath.row]

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch (indexPath.row) {
        case 0:
            let homeViewController = self.storyboard?.instantiateViewControllerWithIdentifier("HomeViewController") as! HomeViewController
            let homeNavController = UINavigationController(rootViewController: homeViewController)
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.centerContainer!.centerViewController = homeNavController
            appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
            
        case 1:
            let ordersTableViewController = self.storyboard?.instantiateViewControllerWithIdentifier("OrdersTableViewController") as! OrdersTableViewController
            let ordersTableNavController = UINavigationController(rootViewController: ordersTableViewController)
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.centerContainer!.centerViewController = ordersTableNavController
            appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
            
        case 2:
            let driverViewController = self.storyboard?.instantiateViewControllerWithIdentifier("DriverTableViewController") as! DriverTableViewController
            let driverNavController = UINavigationController(rootViewController: driverViewController)
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.centerContainer!.centerViewController = driverNavController
            appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
            
        case 3:
            let settingsTableViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SettingsTableViewController") as! SettingsTableViewController
            let settingsNavController = UINavigationController(rootViewController: settingsTableViewController)
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.centerContainer!.centerViewController = settingsNavController
            appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
            
        default: break
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "HomeViewSegue" {
//            if let indexPath = self.tableView.indexPathForSelectedRow {
//                let object = objects[indexPath.row] as! Dictionary<String, AnyObject>
//                let controller = segue.destinationViewController as! HomeViewController
////                controller.detailItem = object
//            } else if segue.identifier == "SettingsViewController" {
//                if let indexPath = self.tableView.indexPathForSelectedRow {
//                    let object = objects[indexPath.row] as! Dictionary<String, AnyObject>
//                    let controller = segue.destinationViewController as! HomeViewController
////                controller.detailItem = object
//                }
//            }
//        }
    }

}
