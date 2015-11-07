//
//  DeliveryLocationsTableViewController.swift
//  Capstone
//
//  Created by John Tunisi on 11/6/15.
//  Copyright © 2015 John Tunisi. All rights reserved.
//

import Parse

class DeliveryLocationsTableViewController: UITableViewController {
    
    var deliveryLocations = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func pullToRefreshActivated(sender: UIRefreshControl) {
        sender.endRefreshing();
    }
    
    
    //TODO grab delivery locations from parse
    func getDeliveryLocations() {
        PFUser.currentUser()!.fetchIfNeededInBackgroundWithBlock { (result, error) -> Void in
//            driver = ((PFUser.currentUser()!.objectForKey("Driver") as? Bool) == nil) ? false : PFUser.currentUser()!.objectForKey("Driver") as! Bool
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return tableView.dequeueReusableCellWithIdentifier("newDeliveryLocationCell", forIndexPath: indexPath)
        } else {
            return tableView.dequeueReusableCellWithIdentifier("locationCell", forIndexPath: indexPath)
        }
    }
    
}
