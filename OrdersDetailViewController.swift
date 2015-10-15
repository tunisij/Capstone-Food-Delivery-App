//
//  OrdersDetailViewController.swift
//  Capstone
//
//  Created by John Tunisi on 10/14/15.
//  Copyright © 2015 John Tunisi. All rights reserved.
//

import UIKit

class OrdersDetailViewController: UIViewController {
    
    var detailItem: AnyObject? {
        didSet {
            self.configureView()
        }
    }
    
    func configureView() {
//        if let detail = self.detailItem as! NSArray? {
//            
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}