//
//  EventMapView.swift
//  Safeye
//
//  Created by iosdev on 28.4.2022.
//

import SwiftUI
import MapKit

struct EventMapView: View {
    
    @ObservedObject var appState: Store
    @EnvironmentObject var eventMapVM: EventMapViewModel
    
    
    var body: some View {
        
        Map(coordinateRegion: $eventMapVM.mapRegion, showsUserLocation: true, annotationItems: [eventMapVM.trackedUser]) { trackedUser in
            MapAnnotation(coordinate: trackedUser.coordinate) {
                Circle()
                    .stroke(.orange, lineWidth: 3)
                    .frame(width: 30, height: 30)
            }
            }
            
            .onAppear {
                eventMapVM.getTrackedUserMapInfo()
                eventMapVM.updateTrackedUser()
            }
            .ignoresSafeArea()
    }

}

//struct EventMapView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventMapView(appState: Store)
//    }
//}
