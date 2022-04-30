//
//  EventMapView.swift
//  Safeye
//
//  Created by iosdev on 28.4.2022.
//

import SwiftUI
import MapKit

struct EventMapView: View {
    
    @EnvironmentObject var appState: Store
    @EnvironmentObject var eventMapVM: EventMapViewModel
        
    var body: some View {
        var cll = CLLocationCoordinate2D(latitude: appState.event!.coordinates["latitude"]!, longitude: appState.event!.coordinates["longitude"]!)
        var x = TrackedUser(name: "name", coordinate: cll)
        
        Map(coordinateRegion: $eventMapVM.mapRegion, showsUserLocation: true, annotationItems: [x]) { trackedUser in
            MapAnnotation(coordinate: trackedUser.coordinate) {
                Circle()
                    .stroke(.orange, lineWidth: 3)
                    .frame(width: 30, height: 30)
            }
            }
            
            .onAppear {
                //eventMapVM.getTrackedUserMapInfo()
                //eventMapVM.updateTrackedUser()
            }
            .ignoresSafeArea()
    }

}

//struct EventMapView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventMapView(appState: Store)
//    }
//}
