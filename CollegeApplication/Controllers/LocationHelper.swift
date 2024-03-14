//
//  LocationHelper.swift
//  CollegeApplication
//
//  Created by RENHO TSAI on 2024/3/14.
//

import Foundation
import CoreLocation
import Contacts

class LocationHelper:NSObject, ObservableObject, CLLocationManagerDelegate{
    // ObservableObject: Combine framework's type for an object with a publisher that emits before the object has changed.
    //The methods that you use to receive events from an associated locatino-manager object.
    
    private let geoCoder = CLGeocoder()
    //An interface for converting between geographic coordinates and place names.
    
    private let locationManager = CLLocationManager()
    //The object that you use to start and stop the delivery of location-related events to your app.
    
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    //Constants indicating the app's authorization to use location services.
    
    @Published var currentLocation: CLLocation?
    //The latitude, longitude, and course information reported by the system.
    
    override init(){
        super.init()
        if(CLLocationManager.locationServicesEnabled()){
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            //The best level of accuracy available.
        }
        //permission check
        self.checkPermission()
        
        if( CLLocationManager.locationServicesEnabled() && ( self.authorizationStatus == .authorizedAlways || self.authorizationStatus == .authorizedWhenInUse)){
            self.locationManager.startUpdatingLocation()
        }else{
            self.requestPermission()
        }
    }//init
    
    func requestPermission(){
        if(CLLocationManager.locationServicesEnabled()){
            self.locationManager.requestWhenInUseAuthorization()
            //request the user's permission to use location services while the app is in use.
        }
    }
    
    func checkPermission(){
        switch self.locationManager.authorizationStatus{
        case .denied:
            //request permission
            self.requestPermission()
            
        case .notDetermined:
            self.requestPermission()
        
        case .restricted:
            self.requestPermission()
        
        case .authorizedAlways:
            self.locationManager.startUpdatingLocation()
            
        case .authorizedWhenInUse:
            self.locationManager.startUpdatingLocation()
        
        default:
            break
        }
    }
    
    // locationManager did change
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function, "Auth status changed: \(self.locationManager.authorizationStatus)")
        self.authorizationStatus = manager.authorizationStatus
    }
    
    //locationManager did update
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //process the received location
        if locations.last != nil {
            print(#function, "most recent location: \(locations.last!)")
            self.currentLocation = locations.last!
        }else{
            // oldest known location
            print(#function, "lastt known location: \(locations.first!)")
            self.currentLocation = locations.first
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function, "Error trying to get location updates: \(error)")
    }
    
    deinit{
        self.locationManager.stopUpdatingLocation()
    }
    
    //convert address to coordinates
    func doForwarGeocoding(address: String, completionHandler:@escaping(CLLocation?, NSError?) -> Void){
        self.geoCoder.geocodeAddressString(address, completionHandler:{ (placemarks, error) in
            if (error != nil){
                print(#function,"Unable to obtain coord for the given address \(error!)")
                completionHandler(nil,error as NSError?)
            } else {
                if let place = placemarks?.first{
                    let matchedLaction = place.location!
                    print(#function, "matchedLocation: \(matchedLaction)")
                    completionHandler(matchedLaction,nil)
                    return
                }
                completionHandler(nil,error as NSError?)
            }
        })
    }
    
    //coordinates > address
    
    func doReverseGeocoding(location:CLLocation,completionHandler:@escaping(String?,NSError?) -> Void){
        self.geoCoder.reverseGeocodeLocation(location, completionHandler: {
            (placemarks, error) in
            if error != nil{
                print(#function, "Unable to obttain street address for the given coordinates \(error!)")
                completionHandler(nil, error as NSError?)
            }else{
                if let placemarkList = placemarks, let firstPlace = placemarks?.first{
                    //get street address from coordinate
                    
                    let street = firstPlace.thoroughfare ?? "NA"
                    let postalCode = firstPlace.postalCode ?? "NA"
                    let country = firstPlace.country ?? "NA"
                    let province = firstPlace.administrativeArea ?? "NA"
                    
                    print(#function, "\(street), \(postalCode), \(country), \(province)")
                    let address = CNPostalAddressFormatter.string(from: firstPlace.postalAddress!, style: .mailingAddress)
                    
                    completionHandler(address,nil)
                    return
                }
            }
        })
    }
}
