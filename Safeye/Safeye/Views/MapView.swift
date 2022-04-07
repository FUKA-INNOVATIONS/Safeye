//
//  MapView.swift
//  Safeye
//
//  Created by FUKA on 1.4.2022.
//

import MapKit
import SwiftUI

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct MapView: View {
    
    @StateObject private var viewModel = MapViewModel()
    
    let locations = [
        Location(name: "Home", coordinate: CLLocationCoordinate2D(latitude: 60.219, longitude: 24.749)),
        Location(name: "Campus", coordinate: CLLocationCoordinate2D(latitude: 60.224, longitude: 24.756)),
        Location(name: "Buck", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
    ]

    
    var body: some View {
        Map(coordinateRegion: $viewModel.mapRegion, showsUserLocation: true, annotationItems: locations) { location in
            MapAnnotation(coordinate: location.coordinate) {
                Circle()
                    .stroke(.red, lineWidth: 3)
                    .frame(width: 44, height: 44)
            }
        }
        .ignoresSafeArea()
        .accentColor(Color(.systemPurple))
        .onAppear {
            viewModel.checkIfLocationServicesIsEnabled()
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
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
            print("Your location is restricted (parental controls)")
        case .denied:
            print("You have denied this permission")
        case .authorizedAlways, .authorizedWhenInUse:
            mapRegion = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
