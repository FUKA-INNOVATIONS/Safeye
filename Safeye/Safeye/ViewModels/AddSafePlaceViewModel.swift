//
//  MapViewModel.swift
//  maptest
//
//  Created by Ali Fahad on 10.4.2022.
//

import SwiftUI
import MapKit

// All map data here

class AddSafePlaceViewModel: NSObject, ObservableObject, CLLocationManagerDelegate{
    
    @Published var mapView = MKMapView()
    
    @Published var region : MKCoordinateRegion!
    //based on location it will set up...
    
    @Published var permissionDenied = false
    @Published var permissionAllow = true
    
    //map type...
    @Published var mapType: MKMapType = .standard
    
    // search text...
    @Published var searchTxt = ""
    
    // searched places...
    @Published var places : [SafePlaceModel] = []
    
    
    //search plces...
    func searchQuery(){

        places.removeAll()
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchTxt
        
        // fetch...
        MKLocalSearch(request: request).start{ (response, _) in
            guard let result = response  else{return}
            self.places = result.mapItems.compactMap({ (item) -> SafePlaceModel? in
                print("LOOOOOcation\(result)")
                return SafePlaceModel(place: item.placemark)
                
            })
        }
    }
    
    //pick search result...
    func selectPlace(place: SafePlaceModel){
        
        searchTxt = ""
        
        guard let coordinate = place.place.location?.coordinate else{return}
        
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = coordinate
        pointAnnotation.title = place.place.name ?? "No Name"
        
        mapView.removeAnnotations(mapView.annotations)
        
        mapView.addAnnotation(pointAnnotation)
        
        //moving map to new location...
        
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
     
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
    }
    
    // updating map type...
    
    func updateMapType(){
        if mapType == .standard{
            mapType = .hybrid
            mapView.mapType = mapType
        }
        else{
            mapType = .standard
            mapView.mapType = mapType
        }
    }
    
    // Focus Loction...
    
    func focusLocation() {
        
        guard let _ = region else{return}
        
        mapView.setRegion(region, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        // checking permission
        switch manager.authorizationStatus{
        case .denied:
            //Allert
            permissionDenied.toggle()
        case .notDetermined:
            //Requesting
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            // if Permission given
            manager.requestLocation()
        default:
            ()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Error
        
        print(error.localizedDescription)
    }
    
    //Getting user region....
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:
    [CLLocation]) {
        
        guard let location = locations.last else{return}
        
        self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        
        // Updating map....
        self.mapView.setRegion(self.region, animated: true)
        
        //Smooth Animations...
        self.mapView.setVisibleMapRect(self.mapView.visibleMapRect, animated: true)
    }
}
