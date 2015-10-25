//
//  OrdersDetailViewController.swift
//  Capstone
//
//  Created by John Tunisi on 10/14/15.
//  Copyright © 2015 John Tunisi. All rights reserved.
//

import UIKit

class OrdersDetailViewController: UIViewController {
    
    var orderHeader: String = "detailTestHeader"
    var orderNumber: Int = -1
    var orderDescription: String = "detailTestDescription"
    
    var detailItem: AnyObject? {
        didSet {
            self.configureView()
        }
    }
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    func configureView() {
//        if let detail = self.detailItem as! NSArray? {
//            
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        
        if orderHeader != ""{
            headerLabel.text = orderHeader
            numberLabel.text = "\(orderNumber)"
            descriptionLabel.text = orderDescription
            
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}