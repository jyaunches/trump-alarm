//
//  LocationManager.swift
//  trump-alarm
//
//  Created by Stephanie Guevara on 10/29/16.
//  Copyright © 2016 yaunches. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    var delegate: CLLocationManagerDelegate!
    var onSuccess: ((String) -> ())?
    var onFailure: ((Error) -> ())?

    
    func requestPermission(onSuccess: ((String) -> ())?, onFailure: @escaping ((Error) -> ())) {
        self.onSuccess = onSuccess
        self.onFailure = onFailure
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    func requestLocation(currentLocation: CLLocation) {

        CLGeocoder().reverseGeocodeLocation(currentLocation) { (placemarks, error) in
            if let _ = error {
                return
            }
            if (placemarks?.count ?? 0)  > 0 {
                let placemark = placemarks!.last!
                 self.onSuccess?([placemark.subThoroughfare, placemark.thoroughfare, placemark.postalCode, placemark.locality, placemark.administrativeArea, placemark.country].flatMap{$0}.joined(separator: " "))
                
            } else {
                print(error?.localizedDescription ?? "")
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.onFailure?(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else {
            return
        }
        self.locationManager.stopUpdatingLocation()
        self.requestLocation(currentLocation: currentLocation)
    }
}
