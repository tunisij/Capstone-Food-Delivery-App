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
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let latitude = model.locationManager.location?.coordinate.latitude
        let longitude = model.locationManager.location?.coordinate.longitude
        initZoom(latitude!, longitude: longitude!)
    }
    
    func initZoom(latitude: Double, longitude: Double) -> Void {
        let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let span = MKCoordinateSpanMake(0.15, 0.12)
        let region = MKCoordinateRegionMake(coordinate, span)
        
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