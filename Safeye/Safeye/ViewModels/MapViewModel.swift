//
//  MapViewModel.swift
//  Safeye
//
//  Created by FUKA on 1.4.2022.
//

import MapKit
import Foundation
import SwiftUI

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let own: Bool
}

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    //static let instance = MapViewModel() ; private init() {}
    
    // If the users does not allow location, map should center on Helsinki
    @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 60.170, longitude: 24.941), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    var safeSpaces: [Location] = []
    private var appState = Store.shared
    var locationManager: CLLocationManager?
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager?.delegate = self
            locationManager?.distanceFilter = 1
            
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
            print("Your location is restricted (parental controls)")
        case .denied:
            print("You have denied this permission")
        case .authorizedAlways, .authorizedWhenInUse:
            mapRegion = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
//    func assignSafeSpaces() {
//        
//        for trusted in self.appState.connectionPofiles {
//            
//            let name = trusted.fullName
//            let latitude = trusted.homeLocation[0]
//            let longitude = trusted.homeLocation[1]
//            let safeSpace = Location(name: name, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), own: false)
//            
//            appState.safeSpacesMap.append(safeSpace)
//        }
//        
//    }
}
