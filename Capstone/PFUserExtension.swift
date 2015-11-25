//
//  PFUserExtension.swift
//  Capstone
//
//  Created by John Tunisi on 11/25/15.
//  Copyright © 2015 John Tunisi. All rights reserved.
//

import Parse

extension PFUser {
    
    func isDriver() -> Bool {
        var driver = false
        PFUser.currentUser()!.fetchIfNeededInBackgroundWithBlock { (result, error) -> Void in
            driver = ((PFUser.currentUser()!.objectForKey("Driver") as? Bool) == nil) ? false : PFUser.currentUser()!.objectForKey("Driver") as! Bool
        }
        
        return driver
    }
}