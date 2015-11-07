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
    
    
    let dataFetcher = GoogleRequest()
    //
    //    let searchRadius: Double = 1000
    //    var searchedTypes = ["pizza"]
    
    
    
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
        
        mapView.delegate = self
        
        hasLocation = false
        
    }
    
    
    
    /**********************************
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
    
    func fetchNearbyPlaces(coordinate: CLLocationCoordinate2D) {
        mapView.clear()
        dataFetcher.loadPlaces(coordinate) { places in
            for place: Place in places {
                let marker = PlaceMarker(place: place)
                print("ADDRESS: \(marker.place.address)")
                marker.map = self.mapView
                
            }
        }
    }
    @IBAction func refreshPlaces(sender: AnyObject) {
        mapView.clear()
        self.fetchNearbyPlaces(mapView.camera.target)
    }
    
    
}
extension HomeViewController: GMSMapViewDelegate {
    
    func didTapMyLocationButtonForMapView(mapView: GMSMapView!) -> Bool {
        
        mapView.selectedMarker = nil
        return false
    }
    
    func mapView(mapView: GMSMapView!, markerInfoContents marker: GMSMarker!) -> UIView! {
        
        let placeMarker = marker as! PlaceMarker

        if let infoView = NSBundle.mainBundle().loadNibNamed("PlaceInfoView", owner: nil, options: nil).first as? PlaceInfoView {
            
            infoView.nameLabel.text = placeMarker.place.name
            infoView.addressLabel.text = placeMarker.place.address
            
            // 4
//            if let photo = placeMarker.place.photo {
//                infoView.placePhoto.image = photo
//            } else {
//                infoView.placePhoto.image = UIImage(named: "generic")
//            }
            
            return infoView
        } else {
            return nil
        }
    }
}
