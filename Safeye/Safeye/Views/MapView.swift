//
//  MapView.swift
//  Safeye
//
//  Created by Safeye Team on 1.4.2022.
//
/*
 Map view you can access it from Profile or from Event View, to see your location and your trusted contacts location on the map
 */

import MapKit
import SwiftUI

//struct Location: Identifiable {
//    let id = UUID()
//    let name: String
//    let coordinate: CLLocationCoordinate2D
//    let own: Bool
//}

struct MapView: View {
    
    @EnvironmentObject var viewModel: MapViewModel
    @EnvironmentObject var appState: Store
    @EnvironmentObject var EventVM: EventViewModel
    @EnvironmentObject var ConnectionVM: ConnectionViewModel
    @EnvironmentObject var SafePlacesVM: SafePlaceViewModel
    
    @State private var draggedOffset = CGSize.zero
    @State private var listOpen = false
    
    var body: some View {
        
        return ZStack {
            Map(coordinateRegion: $viewModel.mapRegion, showsUserLocation: true, annotationItems: appState.locations) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    // TODO create own component for how safe spaces are displayed
                    SafeSpaceComponent(size: 50, own: location.own, name: location.name)
                }
            }
            .ignoresSafeArea()
            .accentColor(Color(.systemPurple))
            .onAppear {
                viewModel.checkIfLocationServicesIsEnabled()
                ConnectionVM.getConnections()
                ConnectionVM.getConnectionProfiles()
                // viewModel.assignSafeSpaces()
            }
            MapCurtainComponent()
                .cornerRadius(20)
                .offset(y: self.draggedOffset.height + 500)
                .gesture(DragGesture()
                    .onChanged { value in
                        // Whilst the drag out list is being dragged
                        
                        if value.translation.height < 0 && !listOpen {
                            // User is opening the trusted contacts list
                            if value.translation.height > -250 {
                                withAnimation { self.draggedOffset = value.translation }
                            }
                            else {
                                withAnimation { self.draggedOffset = CGSize(width: 0, height: -250) }
                            }
                            
                        }
                        else {
                            // User is closing the trusted contacts list
                            if value.translation.height < 250 {
                                withAnimation { self.draggedOffset = CGSize(width: 0, height: value.translation.height - 250) }
                            }
                            else if value.translation.height < 0 {
                                // TODO fix being able to drag list continously up once it has opened
                                withAnimation { self.draggedOffset = CGSize(width: 0, height: -250) }
                            }
                            else {
                                withAnimation { self.draggedOffset = CGSize.zero }
                            }
                        }
                    }
                    .onEnded { value in
                        // When the dragging action stops whilst opening list
                        if !listOpen {
                            // Happens after user removes finger when opening
                            if value.translation.height < -150 {
                                // Past a certain height list will full open
                                withAnimation {
                                    self.draggedOffset = CGSize(width: 0, height: -250)
                                    listOpen = true
                                }
                            }
                            else {
                                // Below that same height list will close
                                withAnimation { self.draggedOffset = CGSize.zero }
                            }
                        }
                        else {
                            // When user is dragging stops whilst closing list
                            if value.translation.height > 150 {
                                // Past this point list will close
                                withAnimation {
                                    self.draggedOffset = CGSize.zero
                                    listOpen = false
                                }
                            }
                            else {
                                // List will remain open
                                withAnimation { self.draggedOffset = CGSize(width: 0, height: -250) }
                            }
                        }
                    }
                )
        }
        .onAppear {
            SafePlacesVM.getSafePlacesOfAuthenticatedtUser()
            print("MapView -> EVENT STATE: \(appState.event?.status.rawValue ?? "")")
            
            EventVM.sendNotification()
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
