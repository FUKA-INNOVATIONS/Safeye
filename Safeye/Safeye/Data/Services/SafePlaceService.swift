//
//  SafePlaceService.swift
//  Safeye
//
//  Created by Safeye team on 23.4.2022.
//

/*
    This service handles communication with the database for adding/fetching/deleting safeSpaces
    for the user.
 
    1. Adds a new safe place to the database for the current user
    2. Retrives all of the users own added safe space, stores in app state
    3. Deletes a specific safeSpace
 */

import Foundation
import MapKit
import Firebase

class SafePlaceService {
    static let shared = SafePlaceService() ; private init() {}
    private var appState = Store.shared
    private var safePlaceDB = Firestore.firestore().collection("safeplace")
    
    
    // Add new safe place to database
    func addSafePlace(_ place: SafePlaceModel) -> Bool {
        
        do {
            _ = try self.safePlaceDB.addDocument(from: place)
            return true
        }
        catch {
            print(error)
            return false
        }
        
    }
    
    
    
    // Fetch list of safe places from the database
    func fetchUserSafePlaces(of userID: String) {
        self.appState.safePlaces.removeAll() // empty safe places collection, move out, not belogning here, fo in all services
        self.appState.locations.removeAll() // empty locations list
        DispatchQueue.main.async {
            self.safePlaceDB.whereField("ownerId", isEqualTo: userID).getDocuments() { places, error in
                if let error = error { print("Error in fetchUserSafePlaces: \(error)") ; return }
                else {
                    if places!.isEmpty { print("Current user has no safe places"); return }
                    if let places = places {
                        for place in places.documents {
                            print("Safe places of current user: \(place)")
                                do {
                                    let convertedPlace = try place.data(as: SafePlaceModel.self)
                                    self.appState.safePlaces.append(convertedPlace)
                                    guard let currentUserID = AuthenticationService.getInstance.currentUser?.uid else { return }
                                    let isOwner = (convertedPlace.ownerId == currentUserID) // temporary solution, not belogning here
                                    let location = Location(name: convertedPlace.name, coordinate: CLLocationCoordinate2D(latitude: convertedPlace.latitude, longitude: convertedPlace.longitude), own: isOwner)
                                    self.appState.locations.append(location)
                                } catch {
                                    print("Error fetchUserSafePlaces 2: \(error)")
                                }
                        }
                    }
                }
            }
        }
    }
    
    
    
    // // delete specific safe place from the database
    func deleteSafePlaceByID(_ safePlaceID: String) {
        self.safePlaceDB.document(safePlaceID).delete() { error in
            if let error = error {
                print("Error deleting safe place: \(error)")
            } else {
                print("Safe place successfully deleted!")
            }
        }
    }
    
    
    
}
