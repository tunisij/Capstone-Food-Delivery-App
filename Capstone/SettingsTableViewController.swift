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

    @IBOutlet weak var searchDistanceTxt: UILabel!
    @IBOutlet weak var driverSignupCell: UITableViewCell!
    
    var currentUser = PFUser.currentUser()
    var isDriver: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        isDriver = currentUser!.isDriver()
        tableView.reloadData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if super.tableView(tableView, cellForRowAtIndexPath: indexPath).reuseIdentifier == "DriverSignupCell" {
            if isDriver {
                return 0
            }
        }
        
        return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
    }
    
    @IBAction func searchDistanceChanged(sender: UISlider) {
        let distance = String(format: "%.1f", sender.value)
        searchDistanceTxt.text = "\(distance) mi."
    }
    
    @IBAction func logoutButtonClicked(sender: UIBarButtonItem) {
        PFUser.logOut()
        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LoginViewController")
        self.presentViewController(viewController, animated: true, completion: nil)
    }
    
    @IBAction func drawerMenuClicked(sender: UIBarButtonItem) {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
}