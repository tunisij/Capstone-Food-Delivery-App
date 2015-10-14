//
//  HomeViewController.swift
//  Capstone
//
//  Created by Ethan Christensen on 9/30/15.
//  Copyright © 2015 John Tunisi. All rights reserved.
//

import UIKit
import MapKit

class HomeViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    var model = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tbc = self.tabBarController  as! MainTabBarController
        model = tbc.model
        model.locationManager.delegate = self
        
        
        
        
        
        //dismiss keyboard
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        mapView.scrollEnabled = true
        mapView.zoomEnabled = true
        mapView.rotateEnabled = true
        mapView.showsCompass = true
        mapView.showsPointsOfInterest = true
        mapView.reloadInputViews()
        
//        let request = MKLocalSearchRequest()
//        request.naturalLanguageQuery = "Pizza"
//        request.region = mapView.region
//        
//        let search = MKLocalSearch(request: request)
//        
//        search.startWithCompletionHandler({(response: MKLocalSearchResponse!,
//            error: NSError!) in
//            
//            if error != nil {
//                println("Error occured in search: \(error.localizedDescription)")
//            } else if response.mapItems.count == 0 {
//                println("No matches found")
//            } else {
//                println("Matches found")
//                
//                for item in response.mapItems as! [MKMapItems] {
//                    println("Name = \(item.name)")
//                    println("Phone = \(item.phoneNumber)")
//                }
//            }
//        })
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let latitude = model.locationManager.location?.coordinate.latitude
        let longitude = model.locationManager.location?.coordinate.longitude
        initZoom(latitude!, longitude: longitude!)
    }
    
    func initZoom(latitude: Double, longitude: Double) -> Void {
        let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegionMakeWithDistance(coordinate, 1000, 1000)
        
        self.mapView.setRegion(region, animated: true)
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, didChangeDragState newState: MKAnnotationViewDragState, fromOldState oldState: MKAnnotationViewDragState) {
        self.mapView.showsPointsOfInterest = true
        self.mapView.showsCompass = true
        self.mapView.showsBuildings = true
    }
    
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}