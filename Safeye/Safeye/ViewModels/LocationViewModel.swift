//
//  LocationViewModel.swift
//  Safeye
//
//  Created by Safeye Team on 1.4.2022.
//

import Foundation
import CoreLocation
import SwiftUI

class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    static let shared = LocationViewModel()
    
    let eventService = EventService.shared
    @ObservedObject private var appState = Store.shared
    
    var locationManager: CLLocationManager?
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager?.delegate = self
            
            
        } else {
            print("Show Alert saying location not active")
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted")
        case .denied:
            print("You have denied this permission")
        case .authorizedAlways, .authorizedWhenInUse:
            break
        @unknown default:
            break
        }
    }
    
    func locationForMap() {
        locationManager?.startUpdatingLocation()
        locationManager?.distanceFilter = 1
    }
    
    func locationDuringTrackingMode() {
        locationManager?.startUpdatingLocation()
        locationManager?.distanceFilter = 100
        locationManager?.allowsBackgroundLocationUpdates = true
        locationManager?.pausesLocationUpdatesAutomatically = false
    }
    
    func locationDuringPanicMode() {
        locationManager?.startUpdatingLocation()
        locationManager?.distanceFilter = 1
        locationManager?.allowsBackgroundLocationUpdates = true
        locationManager?.pausesLocationUpdatesAutomatically = false
    }
    
    // Reruns authorization check if permissions are changed
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    // Runs when a there is a location change specified by the distance filter
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(" COORDNATES locationManager()  called")
        guard let userLoc = locations.last else { return }
        print("COORDNATES \(userLoc.coordinate)")
        if self.appState.event != nil {
            self.appState.event?.coordinates = ["latitude": userLoc.coordinate.latitude, "longitude": userLoc.coordinate.longitude]
            self.eventService.updateEvent(self.appState.event!)
        }
    }
}
