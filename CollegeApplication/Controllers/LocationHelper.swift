//
//  LocationHelper.swift
//  CollegeApplication
//
//  Created by RENHO TSAI on 2024/3/14.
//

import Foundation
import CoreLocation

class LocationHelper: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    @Published var currentLocation: CLLocation?

    override init() {
        super.init()
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
        self.checkPermission()
        if CLLocationManager.locationServicesEnabled() &&
           (self.authorizationStatus == .authorizedAlways || self.authorizationStatus == .authorizedWhenInUse) {
            self.locationManager.startUpdatingLocation()
        } else {
            self.requestPermission()
        }
    }

    func requestPermission() {
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.requestWhenInUseAuthorization()
        }
    }

    func checkPermission() {
        switch self.locationManager.authorizationStatus {
        case .denied, .notDetermined, .restricted:
            self.requestPermission()
        case .authorizedAlways, .authorizedWhenInUse:
            self.locationManager.startUpdatingLocation()
        default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.currentLocation = location
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error trying to get the location updates: \(error)")
    }

    deinit {
        self.locationManager.stopUpdatingLocation()
    }

    func doReverseGeocoding(location: CLLocation, completionHandler: @escaping (String?, NSError?) -> Void) {
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("Unable to obtain street address for the given coordinates: \(error)")
                completionHandler(nil, error as NSError?)
            } else if let placemark = placemarks?.first {
                let street = placemark.thoroughfare ?? "NA"
                let postalCode = placemark.postalCode ?? "NA"
                let country = placemark.country ?? "NA"
                let province = placemark.administrativeArea ?? "NA"
                let address = "\(street), \(postalCode), \(province), \(country)"
                completionHandler(address, nil)
            }
        }
    }
}
