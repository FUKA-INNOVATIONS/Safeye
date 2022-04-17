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

// Check for event statuses on app launch iex. if contact is in PANIC mode ?
// Usually app state is initialized on app launch
// Maybe we initialize the entire state and optionally add it to persistance store and then listen to the database for changes


class Store: ObservableObject {
    static let shared = Store() ; private init() {}
    
    @Published var profile: ProfileModel? = nil
    @Published var profileSearch: ProfileModel?
    @Published var pendingRequests = [ConnectionModel]()
    @Published var connections = [ConnectionModel]()
    @Published var trustedContacts = [ProfileModel]()
    @Published var connectionPofiles = [ProfileModel]()
    @Published var safePlaces = [SafePlaceModel]()
    @Published var settings = [SettingModel]()
    @Published var eventsOfCurrentUser = [Event]()
    @Published var eventsOfTrustedContacts = [Event]()
    @Published var event: Event?
    @Published var eventTrustedContactsProfiles = [ProfileModel]()
    //@Published var eventCurrentUser: Event?
    @Published var panicMode = false
   
    
    @Published var errors = [String]()
    @Published var notifications = [String]()
    
    @Published var eventSelctedContacts = ([ProfileModel])()
    @Published var currentEventTrustedContacts = [ProfileModel]()
    
    @Published var currentUserID = ""
    @Published var currentUserEmail = ""
    @Published var isSignedIn = false
    @Published var lang = "EN" // Save app settings in persistant storage

}



/*extension Store {
    func sayHello(_ newText: String) { self.greeting = "Hello from extention" }
}

extension Store {
    func getPengindgRequests() {}
} */
