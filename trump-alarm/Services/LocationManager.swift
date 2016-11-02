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
    var returnedPlacemark: CLPlacemark?
    
    func requestPermission(onSuccess: ((String) -> ())?, onFailure: @escaping ((Error) -> ())) {
        self.onSuccess = onSuccess
        self.onFailure = onFailure
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
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
            if let placemarks = placemarks {
                if (placemarks.count > 0) && (self.returnedPlacemark == nil) {
                    if let thePlacemark = placemarks.last {
                        self.returnedPlacemark = thePlacemark
                        self.onSuccess?([thePlacemark.subThoroughfare, thePlacemark.thoroughfare, thePlacemark.postalCode, thePlacemark.locality, thePlacemark.administrativeArea, thePlacemark.country].flatMap{$0}.joined(separator: " "))
                    }
                }
            }
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.onFailure?(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locationManager.stopUpdatingLocation()
        guard let currentLocation = locations.last else {
            return
        }
        self.requestLocation(currentLocation: currentLocation)
    }
}
