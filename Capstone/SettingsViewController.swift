//
//  SettingsViewController.swift
//  Capstone
//
//  Created by Ethan Christensen on 9/30/15.
//  Copyright © 2015 John Tunisi. All rights reserved.
//

import UIKit
import ParseFacebookUtilsV4

class SettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func logoutButton(sender: UIButton) {
        PFUser.logOut()
        self.performSegueWithIdentifier(loginSeque, sender: self)
    }
}