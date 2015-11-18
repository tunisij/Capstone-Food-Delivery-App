//
//  GoogleRequest.swift
//  Capstone
//
//  Created by Ethan Christensen on 11/5/15.
//  Copyright © 2015 John Tunisi. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

class GoogleRequest {
    
    var objects = [AnyObject]()
    
    func loadPlaces(coordinate: CLLocationCoordinate2D, searchStr: String, typeStr: String, completion: (([Place]) -> Void)) -> ()
    {
        
        // Get ready to fetch the list of dog videos from YouTube V3 Data API
        var url = NSURL(string: "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(coordinate.latitude),\(coordinate.longitude)&radius=500&types=\(typeStr)&name=\(searchStr)&key=AIzaSyD6A3UC612PRvsyUIk_t5odUkVZveXjO0w")
        if(searchStr == "" && typeStr != ""){
            url = NSURL(string: "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(coordinate.latitude),\(coordinate.longitude)&radius=500&types=\(typeStr)&key=AIzaSyD6A3UC612PRvsyUIk_t5odUkVZveXjO0w")
        }else if(searchStr != "" && typeStr == ""){
            url = NSURL(string: "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(coordinate.latitude),\(coordinate.longitude)&radius=500&name=\(searchStr)&key=AIzaSyD6A3UC612PRvsyUIk_t5odUkVZveXjO0w")
        }
        
        print("REQUEST: \(url)")
        
        let session = NSURLSession.sharedSession()
        let task = session.downloadTaskWithURL(url!) {
            (loc:NSURL?, response:NSURLResponse?, error:NSError?) in
            if error != nil {
                print(error)
                return
            }
            
            // print out the fetched string for debug purposes.
            let d = NSData(contentsOfURL: loc!)!
            print("got data")
            let datastring = NSString(data: d, encoding: NSUTF8StringEncoding)
            print(datastring)
            
            // Parse the top level  JSON object.
            let parsedObject: AnyObject?
            do {
                parsedObject = try NSJSONSerialization.JSONObjectWithData(d,
                    options: NSJSONReadingOptions.AllowFragments)
            } catch let error as NSError {
                print(error)
                return
            } catch {
                fatalError()
            }
            
            // retrieve the individual places from the JSON document.
            if let topLevelObj = parsedObject as? Dictionary<String,AnyObject> {
                if let results = topLevelObj["results"] as? Array<Dictionary<String,AnyObject>> {
                    for i in results {
                        self.objects.append(i)
                        
                    }
                    print("Objects Count: \(self.objects.count)")
                    
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        (UIApplication.sharedApplication().delegate as! AppDelegate).decrementNetworkActivity()
                        //self.tableView.reloadData()
                        
                    }
                }
            }
            
            var placesArray = [Place]()
            for var i = 0; i < self.objects.count; ++i {
                let place = Place(result: self.objects[i])
                placesArray.append(place)
            }
            dispatch_async(dispatch_get_main_queue()) {
                completion(placesArray)
            }
            
            
        }
        
        (UIApplication.sharedApplication().delegate as! AppDelegate).incrementNetworkActivity()
        task.resume()
        
        
    }
    
}
