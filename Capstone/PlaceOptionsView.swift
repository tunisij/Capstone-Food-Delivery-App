//
//  PlaceOptionsView.swift
//  Capstone
//
//  Created by Ethan Christensen on 12/4/15.
//  Copyright © 2015 John Tunisi. All rights reserved.
//

import UIKit

class PlaceOptionsView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    
    @IBAction func PlaceOrderButtonAction(sender: AnyObject) {
    }
    
    @IBAction func AddToFavoritesButtonAction(sender: AnyObject) {
    }
    

}
protocol UIViewLoading {}
extension UIView : UIViewLoading {}

extension UIViewLoading where Self : UIView {
    
    // note that this method returns an instance of type `Self`, rather than UIView
    static func loadFromNib() -> Self {
        let nibName = "\(self)".characters.split{$0 == "."}.map(String.init).last!
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiateWithOwner(self, options: nil).first as! Self
    }
    
}