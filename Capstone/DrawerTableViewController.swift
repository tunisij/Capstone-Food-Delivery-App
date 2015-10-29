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
        let cell = tableView.dequeueReusableCellWithIdentifier("showView", forIndexPath: indexPath)
        
        switch indexPath.row {
        case 0:
            let centerViewController = self.storyboard?.instantiateViewControllerWithIdentifier("HomeViewController") as! HomeViewController
            let centerNavController = UINavigationController(rootViewController: centerViewController)
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.centerContainer!.centerViewController = centerNavController
            appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
            
        case 1:
            let centerViewController = self.storyboard?.instantiateViewControllerWithIdentifier("OrdersTableViewController") as! OrdersTableViewController
            let centerNavController = UINavigationController(rootViewController: centerViewController)
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.centerContainer!.centerViewController = centerNavController
            appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
            
        case 2:
            let centerViewController = self.storyboard?.instantiateViewControllerWithIdentifier("DriverViewController") as! DriverViewController
            let centerNavController = UINavigationController(rootViewController: centerViewController)
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.centerContainer!.centerViewController = centerNavController
            appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
            
        case 3:
            let centerViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SettingsViewController") as! SettingsViewController
            let centerNavController = UINavigationController(rootViewController: centerViewController)
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            appDelegate.centerContainer!.centerViewController = centerNavController
            appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
            
        default: break

        }
        
        

        // Configure the cell...

        return cell
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
