//
//  MainTabBarController.swift
//  Capstone
//
//  Created by John Tunisi, Ross Bryan, Ethan Christensen,  Ethan Keel  on 10/22/15.
//  Copyright © 2015 JJohn Tunisi, Ross Bryan, Ethan Christensen,  Ethan Keel . All rights reserved.
//

import UIKit
import Parse
import ParseUI
import ParseTwitterUtils
import ParseFacebookUtilsV4
import MMDrawerController

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    @IBAction func loginButtonClicked(sender: UIButton) {
        let username = self.usernameTextField.text
        let password = self.passwordTextField.text
        
        // Validate the text fields
        if username!.characters.count < 5 {
            let alert = UIAlertController(title: "Invalid", message: "Username must be at least 5 characters", preferredStyle: UIAlertControllerStyle.Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(defaultAction)
            presentViewController(alert, animated: true, completion: nil)
            
        } else if password!.characters.count < 8 {
            let alert = UIAlertController(title: "Invalid", message: "Password must be at least 8 characters", preferredStyle: UIAlertControllerStyle.Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(defaultAction)
            presentViewController(alert, animated: true, completion: nil)
            
        } else {
            // Run a spinner to show a task in progress
            let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
            spinner.startAnimating()
            
            // Send a request to login
            PFUser.logInWithUsernameInBackground(username!, password: password!, block: { (user, error) -> Void in
                
                // Stop the spinner
                spinner.stopAnimating()
                
                if ((user) != nil) {
                    let alert = UIAlertController(title: "Success", message: "Logged In", preferredStyle: UIAlertControllerStyle.Alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    alert.addAction(defaultAction)
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                        appDelegate.loadMainView()
                        
                        self.dismissViewControllerAnimated(true, completion: nil)
                    })
                    
                } else {
                    let alert = UIAlertController(title: "Error", message: "Incorrect username or password", preferredStyle: UIAlertControllerStyle.Alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    alert.addAction(defaultAction)
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            })
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "signupSegue" {
            let controller = segue.destinationViewController as! SignupViewController
            controller.username = self.usernameTextField.text
        }
    }
    
    
    
//    func checkIfDriver() -> Bool {
//        var driver = false
//        PFUser.currentUser()!.fetchIfNeededInBackgroundWithBlock { (result, error) -> Void in
//            driver = ((PFUser.currentUser()!.objectForKey("Driver") as? Bool) == nil) ? false : PFUser.currentUser()!.objectForKey("Driver") as! Bool
//        }
//
//        return driver
//    }
//    
//    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool {
//        
//        if (!username.isEmpty || !password.isEmpty) {
//            return true
//        } else {
//            return false
//        }
//    }
//    
//    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
//        if PFTwitterUtils.isLinkedWithUser(user) {
//            let twitterUsername = PFTwitterUtils.twitter()!.screenName
//            PFUser.currentUser()!.username = twitterUsername
//            PFUser.currentUser()!.saveEventually(nil)
//        } else if PFFacebookUtils.isLinkedWithUser(user) {
//            getUserDataFromFacebookProfile(user)
//        }
//        self.performSegueWithIdentifier("HomeSegue", sender: self)
//        
//        askForLocation()
//    }
//    
//    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?) {
//        let alert = UIAlertController(title: "Login Error", message: "Please login to Twitter", preferredStyle: UIAlertControllerStyle.Alert)
//        alert.addAction(UIAlertAction(title: "dismiss", style: UIAlertActionStyle.Default, handler: nil))
//        logInController.presentViewController(alert, animated: true, completion: nil)
//    }
//    
//    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
//        if (PFTwitterUtils.isLinkedWithUser(user)) {
//            let twitterUsername = PFTwitterUtils.twitter()!.screenName
//            PFUser.currentUser()!.username = twitterUsername
//            PFUser.currentUser()!.saveEventually(nil)
//        }
//        self.dismissViewControllerAnimated(true, completion: nil)
//    }
//    
//    func signUpViewController(signUpController: PFSignUpViewController, didFailToSignUpWithError error: NSError?) {
//        print("Failed to sign up...")
//    }
//    
//    func getUserDataFromFacebookProfile(user: PFUser) {
//        var username  : String?
//        var userEmail : String?
//
//        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields" : "email, name"] )
//        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
//            
//            if ((error) != nil) {
//                // Process error
//            } else {
//                userEmail = result.valueForKey("email") as? String
//                username = result.valueForKey("name") as? String
//            }
//            
//            let thisUser: PFUser = user
//            
//            if let uName = username {
//                thisUser.username = uName
//            }
//            
//            if let uEmail = userEmail {
//                thisUser.email = uEmail
//            }
//            thisUser.saveInBackground()
//        })
//    }
//    
//    func askForLocation() -> Void {
//        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//    }

}