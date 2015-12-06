//
//  HomeViewController.swift
//  Capstone
//
//  Created by John Tunisi, Ross Bryan, Ethan Christensen,  Ethan Keel  on 9/30/15.
//  Copyright © 2015 John Tunisi, Ross Bryan, Ethan Christensen,  Ethan Keel.  All rights reserved.
//

import UIKit
import MMDrawerController
import GoogleMaps

class HomeViewController: UIViewController, CLLocationManagerDelegate, UIPickerViewDataSource,UIPickerViewDelegate, UISearchBarDelegate {
    
    
    
    @IBOutlet weak var placeOptionsView: UIView!
    
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var typePicker: UIPickerView!
    
    
    
    let pickerData = ["Scroll to Search by Category", "Food/Fast Food", "Restaurant", "Grocery Store", "Convenience Store", "Liquor Store"]
    let typeString = ["", "food", "restaurant", "grocery_or_supermarket", "convenience_store", "liquor_store"]
    
    var selectedType:String = ""
    var searchString:String = ""
    
    var placeName:String = ""
    var placeAddress: String = ""
    
    var searchActive : Bool = false
    var showSearchFields = true
    
    let locationManager = CLLocationManager()
    var hasLocation = false
    
    /**********************************
     *
     *
     **********************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
        mapView.delegate = self
        typePicker.dataSource = self
        typePicker.delegate = self
        searchBar.delegate = self
        
        hasLocation = false
        
        self.view.sendSubviewToBack(placeOptionsView)
        
    }
    
    
    
    /*********************************
     *
     *
     **********************************/
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    
    /**********************************
     *
     *
     **********************************/
    @IBAction func drawerMenuClicked(sender: UIBarButtonItem) {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.centerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
    
    
    
    /**********************************
     *
     *
     **********************************/
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    /**********************************
     *
     *
     **********************************/
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
            mapView.myLocationEnabled = true
            mapView.settings.myLocationButton = true
            
        }
    }
    
    /**********************************
     *
     *
     **********************************/
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            locationManager.stopUpdatingLocation()
            //loadPlaces(location.coordinate)
            
        }
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
//    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
//        var pickerLabel = view as! UILabel!
//        if view == nil {
//            pickerLabel = UILabel()
//            //color the label's background
//            let hue = CGFloat(row)/CGFloat(pickerData.count)
//            pickerLabel.backgroundColor = UIColor(hue: hue, saturation: 1.0, brightness: 30.0, alpha: 30.0)
//        }
//        let titleData = pickerData[row]
//        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 18.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
//        pickerLabel!.attributedText = myTitle
//        pickerLabel!.textAlignment = .Center
//        return pickerLabel
//        
//    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedType = typeString[row]
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        self.searchString = self.searchBar.text!
        return pickerData.count
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        self.searchString = self.searchBar.text!
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.searchString = ""
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.searchString = self.searchBar.text!
        self.fetchNearbyPlaces(mapView.camera.target)
        searchActive = false;
    }
    
    func fetchNearbyPlaces(coordinate: CLLocationCoordinate2D) {
        let dataFetcher = GoogleRequest()
        self.searchString = self.searchBar.text!
        mapView.clear()
        if(self.searchString == "" && self.selectedType == ""){
            let uiAlert = UIAlertController(title: "Missing Search Criteria", message: "Please select a catagory to search, or search for places by name.", preferredStyle: UIAlertControllerStyle.Alert)
            self.presentViewController(uiAlert, animated: true, completion: nil)
            
            uiAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
                
            }))
        }else{
            
            dataFetcher.loadPlaces(coordinate, searchStr: self.cleanSearchString(self.searchString), typeStr: self.selectedType) { places in
                for place: Place in places {
                    let marker = PlaceMarker(place: place)
                    print("ADDRESS: \(marker.place.address)")
                    marker.map = self.mapView
                    
                }
            }
        }
    }
    func cleanSearchString(text: String) -> String {
        let charSet = NSCharacterSet(charactersInString: " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789").invertedSet
        
        let cleanedString = text.componentsSeparatedByCharactersInSet(charSet).joinWithSeparator("").stringByReplacingOccurrencesOfString(" ", withString: "_")
        print(cleanedString)
        
        return cleanedString

    }
    
    @IBAction func refreshSearchButtonAction(sender: UIBarButtonItem) {
        mapView.clear()
        self.view.sendSubviewToBack(self.placeOptionsView)
        self.fetchNearbyPlaces(mapView.camera.target)
    }
   
    @IBAction func placeOrderFromHereButtonAction(sender: UIButton) {
        //CustomerOrderViewController().pickUpNameField.text = self.placeName
        //CustomerOrderViewController().pickUpAddressField.text = self.placeAddress

    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "PlaceOrderFromHereSegue") {
        
            let custOrderViewController = segue.destinationViewController as! CustomerOrderViewController
            custOrderViewController.pickUpNameText = self.placeName
            custOrderViewController.pickUpAddressText = self.placeAddress
        }
    }
    @IBAction func addToFavoritesButtonAction(sender: UIButton) {
    }
   
    
}
extension HomeViewController: GMSMapViewDelegate {
    
    
    func didTapMyLocationButtonForMapView(mapView: GMSMapView!) -> Bool {
        
        mapView.selectedMarker = nil
        return false
    }
    
    
    func mapView(mapView: GMSMapView!, didTapAtCoordinate coordinate: CLLocationCoordinate2D) {
        self.view.sendSubviewToBack(placeOptionsView)
    }

    func mapView(mapView: GMSMapView!, markerInfoWindow marker: GMSMarker!) -> UIView! {
        let placeMarker = marker as! PlaceMarker
        
        if let infoView = NSBundle.mainBundle().loadNibNamed("PlaceInfoView", owner: nil, options: nil).first as? PlaceInfoView {
            
            infoView.nameLabel.text = placeMarker.place.name
            infoView.addressLabel.text = placeMarker.place.address
            
            if(placeMarker.place.open){
                infoView.openLabel.text = "Open Now"
                infoView.openLabel.textColor = UIColor.greenColor()
            }else{
                infoView.openLabel.text = "Closed Now"
                infoView.openLabel.textColor = UIColor.redColor()
            }
            
            self.placeName = placeMarker.place.name
            self.placeAddress = placeMarker.place.address
            
            infoView.iconView.image = placeMarker.place.icon
            self.view.bringSubviewToFront(placeOptionsView)
            self.showSearchFields = false
            return infoView
        } else {
            return nil
        }
    }
    

}