//
//  MapViewModel.swift
//  Safeye
//
//  Created by FUKA on 1.4.2022.
//

/*
    Class that handles the functionality of the mapView containing the users SafeSpaces.
    Retrieves and displays the users safeSpaces (a combination of their own and their trusted
    contacts  home addresses) and displays them on the map. Also hanldes the device location
    permissions and creates/defines the properties of the location manager that handles the
    users own location.
 */
import MapKit
import Foundation
import SwiftUI

// Location struct which stores the information about the users safeSpaces
struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let own: Bool
}

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    // If the users does not allow location, map should center on Helsinki
    @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 60.170, longitude: 24.941), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    var safeSpaces: [Location] = []
    private var appState = Store.shared
    var locationManager: CLLocationManager?
    
    // Creates and defines location manager if location permissions are enabled
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
    
    // asks user for permission for device location, then centers map on their location
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
    
    // Re-checks permissions if they have changed
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
}
