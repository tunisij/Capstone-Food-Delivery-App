//
//  ViewController.swift
//  Capstone
//
//  Created by John Tunisi on 9/25/15.
//  Copyright © 2015 John Tunisi. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import ParseTwitterUtils

class LoginViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if PFUser.currentUser() == nil {
            let loginTitle = UILabel()
            let signupTitle = UILabel()
            loginTitle.text = "Food Delivery"
            signupTitle.text = "Food Delivery"
            
            let loginViewController = PFLogInViewController()
            loginViewController.logInView?.logo = loginTitle
            loginViewController.delegate = self
            loginViewController.fields = [.UsernameAndPassword, .LogInButton, .SignUpButton, .PasswordForgotten, .Facebook, .Twitter]
            
            let signupViewController = PFSignUpViewController()
            signupViewController.signUpView?.logo = signupTitle
            signupViewController.delegate = self
            loginViewController.signUpController = signupViewController
            
            self.presentViewController(loginViewController, animated: true, completion: nil)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool {
        
        if (!username.isEmpty || !password.isEmpty) {
            return true
        } else {
            return false
        }
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        if (PFTwitterUtils.isLinkedWithUser(user)) {
            let twitterUsername = PFTwitterUtils.twitter()!.screenName
            PFUser.currentUser()!.username = twitterUsername
            PFUser.currentUser()!.saveEventually(nil)
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?) {
        let alert = UIAlertController(title: "Login Error", message: "Please login to Twitter", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
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

}

