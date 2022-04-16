//
//  appState.swift
//  Safeye
//
//  Created by FUKA on 14.4.2022.
//

import Foundation
import SwiftUI

// Single source of truth for application state
// Authentication is excluded

class Store: ObservableObject {
    static let shared = Store() ; private init() {}
    
    @Published var profile: ProfileModel?
    @Published var pendingRequests = [ConnectionModel]()
    @Published var trustedContacts = [ProfileModel]()
    @Published var safePlaces = [SafePlaceModel]()
    @Published var settings = [SettingModel]()
    @Published var events = [Event]()
    @Published var event: Event?
    @Published var panicMode = false
    
    @Published var errors = [String]()
    @Published var notifications = [String]()
    
    @Published var selectedPhoto = [FileModel]()

}



/*extension Store {
    func sayHello(_ newText: String) { self.greeting = "Hello from extention" }
}

extension Store {
    func getPengindgRequests() {}
} */
