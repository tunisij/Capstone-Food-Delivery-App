//
//  MainTabBarController.swift
//  Capstone
//
//  Created by John Tunisi on 9/30/15.
//  Copyright © 2015 John Tunisi. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import ParseTwitterUtils
import ParseFacebookUtilsV4

class MainTabBarController: UITabBarController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {
    var tabBarViewControllers:[UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        tabBarViewControllers = self.viewControllers!
        
        if PFUser.currentUser() == nil {
            //let loginTitle = UILabel()
            //            let signupTitle = UILabel()
            //            loginTitle.text = "Food Delivery"
            //            signupTitle.text = "Food Delivery"
            
            let loginViewController = PFLogInViewController()
            //            loginViewController.logInView?.logo = loginTitle
            loginViewController.delegate = self
            loginViewController.fields = [.UsernameAndPassword, .LogInButton, .SignUpButton, .PasswordForgotten, .Facebook, .Twitter]
            
            //            let signupViewController = PFSignUpViewController()
            //            signupViewController.signUpView?.logo = signupTitle
            //            signupViewController.delegate = self
            //            loginViewController.signUpController = signupViewController
            
            self.presentViewController(loginViewController, animated: false, completion: nil)
        }
    }
    
    func checkIfDriver() -> Bool {
        var driver = false
        PFUser.currentUser()!.fetchIfNeededInBackgroundWithBlock { (result, error) -> Void in
            driver = ((PFUser.currentUser()!.objectForKey("Driver") as? Bool) == nil) ? false : PFUser.currentUser()!.objectForKey("Driver") as! Bool
        }

        return driver
    }
    
    func setDriverTab(isDriver: Bool) -> Void {
        if !isDriver && tabBarViewControllers.count == 5 {
            tabBarViewControllers.removeAtIndex(2)
            self.setViewControllers(tabBarViewControllers, animated: true)
        }
    }
    
    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool {
        
        if (!username.isEmpty || !password.isEmpty) {
            return true
        } else {
            return false
        }
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        if PFTwitterUtils.isLinkedWithUser(user) {
            let twitterUsername = PFTwitterUtils.twitter()!.screenName
            PFUser.currentUser()!.username = twitterUsername
            PFUser.currentUser()!.saveEventually(nil)
        } else if PFFacebookUtils.isLinkedWithUser(user) {
            getUserDataFromFacebookProfile(user)
        }
        self.dismissViewControllerAnimated(true, completion: nil)
        
        setDriverTab(checkIfDriver())
    }
    
    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?) {
        let alert = UIAlertController(title: loginError, message: pleaseloginToTwitter, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: dismiss, style: UIAlertActionStyle.Default, handler: nil))
        logInController.presentViewController(alert, animated: true, completion: nil)
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        if (PFTwitterUtils.isLinkedWithUser(user)) {
            let twitterUsername = PFTwitterUtils.twitter()!.screenName
            PFUser.currentUser()!.username = twitterUsername
            PFUser.currentUser()!.saveEventually(nil)
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didFailToSignUpWithError error: NSError?) {
        print("Failed to sign up...")
    }
    
    func getUserDataFromFacebookProfile(user: PFUser) {
        var username  : String?
        var userEmail : String?

        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: me, parameters: [fields : "email, name"] )
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil) {
                // Process error
            } else {
                userEmail = result.valueForKey(email) as? String
                username = result.valueForKey(name) as? String
            }
            
            let thisUser: PFUser = user
            
            if let uName = username {
                thisUser.username = uName
            }
            
            if let uEmail = userEmail {
                thisUser.email = uEmail
            }
            thisUser.saveInBackground()
        })
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
//        if (segue.identifier == "segueTest") {
//            var svc = segue!.destinationViewController as SettingsViewController;
//            
//            svc.toPass = textField.text
//            
//        }
//    }
}