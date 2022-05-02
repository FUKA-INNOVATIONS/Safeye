//
//  PlaygroundViewModel.swift
//  Safeye
//
//  Created by Safeye team on 14.4.2022.
//

/*
        As the name might explain, this is just a place where you are allowed to do what ever you like :)
 */

import Foundation

class PlaygroundViewModel: ObservableObject {
    static let shared = PlaygroundViewModel() ; private init() {}
    private let connService = ConnectionService.shared
    private let eventService = EventService.shared
    
    func getEvent(_ eventID: String) {
        print("getEvent")
    }
    
    func fetchConn() {
    }
    
}
