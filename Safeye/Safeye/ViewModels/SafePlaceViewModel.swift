//
//  SafePlaceViewModel.swift
//  Safeye
//
//  Created by Safeye team on 6.4.2022.


/*
        This class isSapfe places related functionalities:
        Safe places are saved in database and user can view them on the map.
 
        1. Adding a new safe place. User searches for safe place and selected place's coordinates and name is saved in database
        2. Getting a list of currently authenicated user's safe places (saved safe places)
        3. Deleting a safe place
 */


import Foundation
import MapKit

class SafePlaceViewModel: ObservableObject {
    static let shared = SafePlaceViewModel() ; private init() {}
    private var safePlaceService = SafePlaceService.shared
    private var appState = Store.shared
    
    
    
    // Create new safe place
    func createSafePlace(_ place: MKMapItem)  -> Bool {
        // Prevent duplicates to be stored in database
        if (self.appState.safePlaces.filter { $0.name == place.placemark.name! }.count) > 0 {
            print("Save place not saved becuase user already have created a place with same name")
            return false
        }
        
        guard let currentUserID = AuthenticationService.getInstance.currentUser?.uid else { return false } // Current user id
        // Extract selected location details
        let locationName = place.placemark.name!
        let longitude = place.placemark.coordinate.longitude
        let latitude = place.placemark.coordinate.latitude
        
        // Save new location, returns a boolean
        let newPlace = SafePlaceModel(ownerId: currentUserID, name: locationName, longitude: longitude, latitude: latitude)
        let didCreate =  safePlaceService.addSafePlace(newPlace)
        return didCreate // was place created successfully? returns true/false
        
    }
    
    
    
    // Get list of safe places and sotre in appState.safePlaces collection
    func getSafePlacesOfAuthenticatedtUser() {
        guard let currentUserID = AuthenticationService.getInstance.currentUser?.uid else { return } // Current usre id
        self.safePlaceService.fetchUserSafePlaces(of: currentUserID)
        for trusted in appState.connectionPofiles {
            if trusted.homeLatitude != nil {
                let trustedLocation = Location(name: trusted.fullName, coordinate: CLLocationCoordinate2D(latitude: trusted.homeLatitude!, longitude: trusted.homeLongitude!), own: false)
                appState.locations.append(trustedLocation)
            }
        }
    }
    
    
    // delete specific safe place
    func deleteSafePlaceByID(_ safePlaceID: String) {
        self.safePlaceService.deleteSafePlaceByID(safePlaceID)
    }
    
    
}
