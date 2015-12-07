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
        
        getDeliveryLocations()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func pullToRefreshActivated(sender: UIRefreshControl) {
        getDeliveryLocations()
        sender.endRefreshing();
    }
    
    
    func getDeliveryLocations() {
        let query = PFQuery(className:"DeliveryLocation")
        query.whereKey("User", equalTo: PFUser.currentUser()!)
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
            
            if let object = deliveryLocations[indexPath.row - 1] as? Dictionary<String, String> {
                cell.textLabel?.text = object["Nickname"]
                let address = object["Address"]
                let city = object["City"]
                let state = object["State"]
                cell.detailTextLabel?.text = "\(address!) \(city!), \(state!)"
            }
            
            return cell
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
}
