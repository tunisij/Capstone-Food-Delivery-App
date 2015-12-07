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
    
    
    func getDeliveryLocations() {
        let query = PFQuery(className:"DeliveryLocation")
        query.whereKey("Username", equalTo: PFUser.currentUser()!.username!)
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                if let objects = objects {
                    self.deliveryLocations.removeAll()
                    for object in objects {
                        var instance = Dictionary<String, String>()
                        instance["Nickname"] = object["Nickname"] as? String
                        instance["Address"] = object["Address"] as? String
                        instance["City"] = object["City"] as? String
                        instance["State"] = object["State"] as? String
                        instance["ZipCode"] = object["ZipCode"] as? String
                        
                        self.deliveryLocations.append(instance)
                        self.tableView.reloadData()
                    }
                }
            } else {
                print("Error: \(error!) \(error!.userInfo)")
            }
        }

    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deliveryLocations.count + 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return tableView.dequeueReusableCellWithIdentifier("newDeliveryLocationCell", forIndexPath: indexPath)
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("locationCell", forIndexPath: indexPath)
            
            if let object = deliveryLocations[indexPath.row] as? Dictionary<String, String> {
                cell.textLabel?.text = object["Nickname"]
            }
            
            return cell
        }
    }
    
}
