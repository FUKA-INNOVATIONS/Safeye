//
//  EventMapViewModel.swift
//  Safeye
//
//  Created by iosdev on 28.4.2022.
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
    
    
}

