//
//  SettingsViewController.swift
//  Capstone
//
//  Created by John Tunisi, Ross Bryan, Ethan Christensen,  Ethan Keel  on 10/22/15.
//  Copyright © 2015 JJohn Tunisi, Ross Bryan, Ethan Christensen,  Ethan Keel . All rights reserved.
//

import UIKit
import ParseFacebookUtilsV4
import MMDrawerController

class SettingsTableViewController: UITableViewController {
    var currentUser = PFUser.currentUser()

    override func viewDidLoad() {
        super.viewDidLoad()        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SwitchCell", forIndexPath: indexPath)
        
        return cell
    }
    
    func checkIfDriver() -> Bool {
        var driver = false
        PFUser.currentUser()!.fetchIfNeededInBackgroundWithBlock { (result, error) -> Void in
            driver = ((PFUser.currentUser()!.objectForKey("Driver") as? Bool) == nil) ? false : PFUser.currentUser()!.objectForKey("Driver") as! Bool
        }
        
        return driver
    }
    
    @IBAction func logoutButtonClicked(sender: UIBarButtonItem) {
        PFUser.logOut()
        self.performSegueWithIdentifier("loginSegue", sender: self)
    }
    
    @IBAction func driverSwitch(sender: UISwitch) {
        if sender.on {
            PFUser.currentUser()?.setValue(true, forKey: "Driver")
        } else {
            PFUser.currentUser()?.setValue(false, forKey: "Driver")
        }
        PFUser.currentUser()?.saveEventually()
    }
    
    @IBAction func drawerMenuClicked(sender: UIBarButtonItem) {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
}