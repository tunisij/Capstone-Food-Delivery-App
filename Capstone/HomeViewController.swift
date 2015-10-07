//
//  HomeViewController.swift
//  Capstone
//
//  Created by Ethan Christensen on 9/30/15.
//  Copyright © 2015 John Tunisi. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class HomeViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var MapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        print("\(locationManager.location?.coordinate.latitude)")
        print("\(locationManager.location?.coordinate.longitude)")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
//    func displayLocationInfo(placemark: CLPlacemark) {
//        if placemark != nil {
//            //stop updating location to save battery life
//            locationManager.stopUpdatingLocation()
//            println(placemark.locality ? placemark.locality : "")
//            println(placemark.postalCode ? placemark.postalCode : "")
//            println(placemark.administrativeArea ? placemark.administrativeArea : "")
//            println(placemark.country ? placemark.country : "")
//        }
//    }
}