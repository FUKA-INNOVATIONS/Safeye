//
//  EventMapViewModel.swift
//  Safeye
//
//  Created by Safeye Team on 1.4.2022.
//

import MapKit
import Foundation
import SwiftUI

struct TrackedUser: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

class EventMapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    var trackingTimer: Timer?
    
    static let shared = EventMapViewModel() ;  private override init() {}
    @ObservedObject var appState = Store.shared
    
    @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.33759267, longitude: -122.03725747), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    @Published var trackedUser = TrackedUser(name: "Trusted Contact", coordinate: CLLocationCoordinate2D(latitude: 60.170, longitude: 24.941))
    
    
    //    func getTrackedUserMapInfo() {
    //        let coordinates = appState.event!.coordinates.values
    //        let userCoords = coordinates.map { $0 }
    //
    //        trackedUser = TrackedUser(name: "Trusted Contact", coordinate: CLLocationCoordinate2D(latitude: userCoords[0], longitude: userCoords[1]))
    //        mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: userCoords[0], longitude: userCoords[1]), span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3))
    //    }
    
    
    //    func updateTrackedUser() {
    //        trackingTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(5), repeats: true) { timer in
    //            let coordinates = self.appState.event!.coordinates.values
    //            let userCoords = coordinates.map { $0 }
    //
    //            self.trackedUser = TrackedUser(name: "Trusted Contact", coordinate: CLLocationCoordinate2D(latitude: userCoords[0], longitude: userCoords[1]))
    //        }
    //    }
    
}

