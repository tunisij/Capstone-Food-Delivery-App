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

class SettingsViewController: UIViewController {
    var currentUser = PFUser.currentUser()
    var model = Model()
    
    @IBOutlet weak var driverSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let tbc = self.tabBarController  as! MainTabBarController
//        model = tbc.model
//        
//        driverSwitch.setOn(checkIfDriver(), animated: false)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func checkIfDriver() -> Bool {
        var driver = false
        PFUser.currentUser()!.fetchIfNeededInBackgroundWithBlock { (result, error) -> Void in
            driver = ((PFUser.currentUser()!.objectForKey("Driver") as? Bool) == nil) ? false : PFUser.currentUser()!.objectForKey("Driver") as! Bool
        }
        
        return driver
    }
    
    @IBAction func logoutButton(sender: UIButton) {
        PFUser.logOut()
        self.performSegueWithIdentifier(loginSegue, sender: self)
    }
    
    @IBAction func driverSwitch(sender: UISwitch) {
        if sender.on {
            PFUser.currentUser()?.setValue(true, forKey: driver)
        } else {
            PFUser.currentUser()?.setValue(false, forKey: driver)
        }
        PFUser.currentUser()?.saveEventually()
    }
    
    @IBAction func drawerMenuClicked(sender: UIBarButtonItem) {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
}