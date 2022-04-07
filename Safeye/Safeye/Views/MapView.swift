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
    
    /*
     Locations array:
     Currently made up of dummy data
     TODO fetch the home locations of users trusted contacts and their own created
     safe spaces to use
    */
    let locations = [
        Location(name: "SafeSpace 1", coordinate: CLLocationCoordinate2D(latitude: 60.170011, longitude: 24.937062)),
        Location(name: "SafeSpace 2", coordinate: CLLocationCoordinate2D(latitude: 60.167650, longitude: 24.962106)),
        Location(name: "SafeSpace 3", coordinate: CLLocationCoordinate2D(latitude: 60.164396, longitude: 24.937056)),
        Location(name: "SafeSpace 4", coordinate: CLLocationCoordinate2D(latitude: 60.181991, longitude: 24.950927))
        
    ]
    
    var body: some View {
        Map(coordinateRegion: $viewModel.mapRegion, showsUserLocation: true, annotationItems: locations) { location in
            MapAnnotation(coordinate: location.coordinate) {
                // TODO create own component for how safe spaces are displayed
                Circle()
                    .stroke(.blue, lineWidth: 3)
                    .frame(width: 20, height: 20)
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
