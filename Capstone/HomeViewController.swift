//
//  HomeViewController.swift
//  Capstone
//
//  Created by John Tunisi, Ross Bryan, Ethan Christensen,  Ethan Keel  on 9/30/15.
//  Copyright © 2015 John Tunisi, Ross Bryan, Ethan Christensen,  Ethan Keel.  All rights reserved.
//

import UIKit
import MapKit
import MMDrawerController
import GoogleMaps

class HomeViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    //@IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mapView: GMSMapView!
    
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
        
        hasLocation = false
    }
    
    /**********************************
     *
     *
     **********************************/
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
//    override func viewDidLayoutSubviews() {
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
//    }
    
//    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if !hasLocation {
//            hasLocation = true
//            locationManager.stopUpdatingLocation()
//            locationManager.startMonitoringSignificantLocationChanges()
//            
//            let locationArray = locations as NSArray
//            let locationObj = locationArray.lastObject as! CLLocation
//            let coord = locationObj.coordinate
//            
//            initZoom(coord.latitude, longitude: coord.longitude)
//        }
//    }
    
//    func initZoom(latitude: Double, longitude: Double) -> Void {
//        let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//        let region = MKCoordinateRegionMakeWithDistance(coordinate, 1000, 1000)
//        
//        self.mapView.setRegion(region, animated: true)
//    }
//    
//    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, didChangeDragState newState: MKAnnotationViewDragState, fromOldState oldState: MKAnnotationViewDragState) {
//        self.mapView.showsPointsOfInterest = true
//        self.mapView.showsCompass = true
//        self.mapView.showsBuildings = true
//    }
    
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
        }
        
    }
}



