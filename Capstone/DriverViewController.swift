//
//  DriverViewController.swift
//
//  Created by Travis Keel
//  Copyright © 2015 A. Abdurrahman. All rights reserved.

import UIKit
import MMDrawerController

class DriverViewController: UIViewController {
    
    enum TabIndex : Int {
        case FirstChildTab = 0
        case SecondChildTab = 1
    }
    
    @IBOutlet weak var segmentedControl: SegmentedDriverControl!
    
    @IBOutlet weak var contentView: UIView!
    
    var currentViewController: UIViewController?
    lazy var firstChildTabVC: UIViewController? = {
        let firstChildTabVC = self.storyboard?.instantiateViewControllerWithIdentifier("RequestViewController")
        return firstChildTabVC
        }()
    lazy var secondChildTabVC : UIViewController? = {
        let secondChildTabVC = self.storyboard?.instantiateViewControllerWithIdentifier("AcceptedViewController")
        return secondChildTabVC
        }()
    
    
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.initUI()
        segmentedControl.selectedSegmentIndex = TabIndex.FirstChildTab.rawValue
        displayCurrentTab(TabIndex.FirstChildTab.rawValue)

    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if let currentViewController = currentViewController {
            currentViewController.viewWillDisappear(animated)
        }
    }
    
    // MARK: - Switching Tabs Functions
    @IBAction func switchTabs(sender: UISegmentedControl) {
        self.currentViewController!.view.removeFromSuperview()
        self.currentViewController!.removeFromParentViewController()
        
        displayCurrentTab(sender.selectedSegmentIndex)
    }
    
    func displayCurrentTab(tabIndex: Int){
        if let vc = viewControllerForSelectedSegmentIndex(tabIndex) {
            
            self.addChildViewController(vc)
            vc.didMoveToParentViewController(self)
            
            vc.view.frame = self.contentView.bounds
            self.contentView.addSubview(vc.view)
            self.currentViewController = vc
        }
    }
    
    func viewControllerForSelectedSegmentIndex(index: Int) -> UIViewController? {
        var vc: UIViewController?
        switch index {
        case TabIndex.FirstChildTab.rawValue :
            vc = firstChildTabVC
        case TabIndex.SecondChildTab.rawValue :
            vc = secondChildTabVC
        default:
            return nil
        }
        
        return vc
    }
    
    /**********************************
    *
    *
    **********************************/
    @IBAction func drawerMenuClicked(sender: UIBarButtonItem) {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
}
