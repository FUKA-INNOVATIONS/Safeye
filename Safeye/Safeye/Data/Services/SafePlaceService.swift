//
//  SafePlaceService.swift
//  Safeye
//
//  Created by FUKA on 23.4.2022.
//

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
            _ = try safePlaceDB.addDocument(from: place)
            return true
        }
        catch {
            print(error)
            return false
        }
        
    }
    
    // Fetch list of safe places from the database
    func fetchUserSafePlaces(of userID: String) {
        self.appState.safePlaces.removeAll() // empty safe places collection
        self.appState.locations.removeAll() // empty locations list
        
        
        
        self.safePlaceDB.whereField("ownerId", isEqualTo: userID).getDocuments() { places, error in
            if let error = error { print("Error in fetchUserSafePlaces: \(error)") ; return }
            else {
                if places!.isEmpty { print("Current user has no safe places"); return }
                if let places = places {
                    for place in places.documents {
                        print("Safe places of current user: \(place)")
                        DispatchQueue.main.async {
                            do {
                                let convertedPlace = try place.data(as: SafePlaceModel.self)
                                self.appState.safePlaces.append(convertedPlace)
                                let isOwner = (convertedPlace.ownerId == AuthenticationService.getInstance.currentUser!.uid) // temporary solution, not belogning here
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
    func deleteSafePlaceByID(_ safePlaceID: String) {}
}
