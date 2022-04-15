//
//  PlaygroundViewModel.swift
//  Safeye
//
//  Created by FUKA on 14.4.2022.
//

import Foundation

class PlaygroundViewModel: ObservableObject {
    static let shared = PlaygroundViewModel() ; private init() {}
    private let connService = ConnectionService.shared
    private let eventService = EventService.shared
    
    func getEvent(_ eventID: String) {
        print("getEvent")
        eventService.fetchDetails(eventID: eventID)
    }
    
    func fetchConn() {
        self.connService.fetchPendingConnectionRequests()
    }
    
}
