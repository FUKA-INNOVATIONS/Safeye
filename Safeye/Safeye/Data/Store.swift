//
//  appState.swift
//  Safeye
//
//  Created by FUKA on 14.4.2022.
//

import Foundation
import SwiftUI

// Single source of truth for application state, FUKA pattern inspired by the REDUCX pattern, MVVM+ ?
// Authentication is excluded

// Usually whole app state is initialized on app launch
// If there is any sense, maybe we initialize the entire state and optionally add it to persistance store and then listen to the database for changes and updating persistant store

// In many cases, Set as data structure would be the right choise but unfortunatley Sets cant be used in SwiftUI lists, at least in the oroiginal form

class Store: ObservableObject {
    static let shared = Store() ; private init() {}
    
    @Published var profile: ProfileModel? = nil
    @Published var profileSearch: ProfileModel?
    @Published var pendingConnectionRequestsOwner = [ConnectionModel]()
    @Published var pendingConnectionRequestsTarget = [ConnectionModel]()
    @Published var connections = [ConnectionModel]() // Trusted contacts, status = true
    @Published var trustedContacts = [ProfileModel]()
    @Published var connectionPofiles = [ProfileModel]()
    @Published var pendingConnectionRequestProfilesOwner = [ProfileModel]()
    @Published var pendingConnectionRequestProfilesTarget = [ProfileModel]()
    @Published var panicPofiles = [ProfileModel]()
    @Published var tCProfile: ProfileModel?
    
    @Published var userPhoto: UIImage?
    @Published var searchResultPhoto: UIImage?
    @Published var trustedContactPhoto: UIImage?

    @Published var safePlaces = [SafePlaceModel]()
    @Published var locations = [Location]()  // temporary solutoin
    
    @Published var eventsOfCurrentUser = [Event]()
    @Published var eventsOfTrustedContacts = [Event]()
    @Published var event: Event?
    @Published var eventTrustedContactsProfiles = [ProfileModel]()
    @Published var panicMode = false
    @Published var cities = [String]()
   
    
    @Published var errors = [String]()
    @Published var notifications = [String]()
    
    @Published var eventSelctedContacts = ([ProfileModel])()
    @Published var currentEventTrustedContacts = [ProfileModel]()
    @Published var eventsPanic = [Event]()
    
    @Published var currentUserID = ""
    @Published var currentUserEmail = ""
    @Published var isSignedIn = false
    @Published var lang = "EN" // Save app settings in persistant storage
    
    @Published var safeSpacesMap = [Location]()

    @Published var appLoading = false

}



/*extension Store {
    func sayHello(_ newText: String) { self.greeting = "Hello from extention" }
}

extension Store {
    func getPengindgRequests() {}
} */
