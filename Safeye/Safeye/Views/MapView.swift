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
    let own: Bool
}

struct MapView: View {
    
    @EnvironmentObject var viewModel: MapViewModel
    
    @State private var draggedOffset = CGSize.zero
    @State private var listOpen = false
    
    /*
     Locations array:
     Currently made up of dummy data
     TODO fetch the home locations of users trusted contacts and their own created
     safe spaces to use
    */
    let locations = [
        Location(name: "SafeSpace 1", coordinate: CLLocationCoordinate2D(latitude: 60.170011, longitude: 24.937062), own: true),
        Location(name: "SafeSpace 2", coordinate: CLLocationCoordinate2D(latitude: 60.167650, longitude: 24.962106), own: false),
        Location(name: "SafeSpace 3", coordinate: CLLocationCoordinate2D(latitude: 60.164396, longitude: 24.937056), own: false),
        Location(name: "SafeSpace 4", coordinate: CLLocationCoordinate2D(latitude: 60.181991, longitude: 24.950927), own: true),
    ]
    
    //let locations = [
      //  safeSpace1, safeSpace2
    //]
    
    var body: some View {
        
        ZStack {
            Map(coordinateRegion: $viewModel.mapRegion, showsUserLocation: true, annotationItems: locations) { location in
                        MapAnnotation(coordinate: location.coordinate) {
                            // TODO create own component for how safe spaces are displayed
                            if location.own == true {
                                // Users own created safe space
                                Circle()
                                    .stroke(.purple, lineWidth: 3)
                                    .frame(width: 30, height: 30)
                            } else {
                                // Trusted contacts home location
                            Circle()
                                .stroke(.blue, lineWidth: 3)
                                .frame(width: 20, height: 20)
                            }
                        }
                    }
                    .ignoresSafeArea()
                    .accentColor(Color(.systemPurple))
                    .onAppear {
                        viewModel.checkIfLocationServicesIsEnabled()
                    }
            MapCurtainComponent()
                .cornerRadius(20)
                .offset(y: self.draggedOffset.height + 470)
                .gesture(DragGesture()
                    .onChanged { value in
                        // Whilst the drag out list is being dragged
                    
                    if value.translation.height < 0 && !listOpen {
                        // User is opening the trusted contacts list
                        if value.translation.height > -250 {
                            self.draggedOffset = value.translation
                        }
                        else {
                            self.draggedOffset = CGSize(width: 0, height: -250)
                        }
                        
                    }
                    else {
                        // User is closing the trusted contacts list
                        if value.translation.height < 250 {
                            self.draggedOffset = CGSize(width: 0, height: value.translation.height - 250)
                        }
                        else if value.translation.height < 0 {
                            // TODO fix being able to drag list continously up once it has opened
                            self.draggedOffset = CGSize(width: 0, height: -250)
                        }
                        else {
                            self.draggedOffset = CGSize.zero
                        }
                    }
                    
                    
                }
                    .onEnded { value in
                        // When the dragging action stops whilst opening list
                    if !listOpen {
                        // Happens after user removes finger when opening
                        if value.translation.height < -150 {
                            // Past a certain height list will full open
                            self.draggedOffset = CGSize(width: 0, height: -250)
                            listOpen = true
                        }
                        else {
                            // Below that same height list will close
                            self.draggedOffset = CGSize.zero
                        }
                    }
                    else {
                        // When user is dragging stops whilst closing list
                        if value.translation.height > 150 {
                            // Past this point list will close
                            self.draggedOffset = CGSize.zero
                            listOpen = false
                        }
                        else {
                            // List will remain open
                            self.draggedOffset = CGSize(width: 0, height: -250)
                        }
                    }
                    
                    
                    
                }
                )
        }
        
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MapView()
            MapView()
        }
    }
}
