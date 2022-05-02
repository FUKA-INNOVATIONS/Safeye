//
//  ProfileViewModel.swift
//  Safeye
//
//  Created by Safeye team on 6.4.2022.


/*
        This class is handling REGISTERED USER'S PROFILE related functionalities.
 
        1. Updating profile details. User can update own profile details
        2. Updating authenicated user's device location coordinates. Used so see trusted contact's location on map
        3. Getting a specific profile by profile owners connection code.
        4. Getting currently authenicated user's profile details
        5. Create new profile. User is obligated to create a profile after registration.
 */

import Foundation
import SwiftUI
import CoreLocation

class ProfileViewModel: NSObject, ObservableObject {
    static let shared = ProfileViewModel() ; private override init() {}
    let profileService = ProfileService.shared
    var AuthVM = AuthenticationViewModel.shared
    var appState = Store.shared
    
    
    // Update profile details
    func updateProfile(_ fullName: String, _ address: String, _ birthday: String, _ bloodType: String, _ illness: String, _ allergies: String, _ avatar: String) {
        guard let profileID = self.appState.profile?.id else {
            print("updateProfile -> profile id not found in app state")
            return
        }
        self.profileService.updateProfile(profileID, fullName, address, birthday, bloodType, illness, allergies, avatar)
        self.getProfileForCurrentUser() // update app state
    }
    
    
    // Update authenicated user's device location coordinates
    func updateUserHomeCoordinates() {
        guard let profileID = self.appState.profile?.id else {
            print("updateProfile -> profile id not found in app state")
            return
        }
        let locationManager = CLLocationManager()
        self.profileService.updateUserHomeLocationCoordinates(profileID, [locationManager.location!.coordinate.latitude, locationManager.location!.coordinate.longitude])
    }
    
    
    // Get a specific profile by profile owners connection code
    func getProfileByConnectionCode(withCode connectionCode: String) {
        self.profileService.fetchProfileByConnectionCode(connCode: connectionCode)
    }
    
    
    // Get surrent user's profile
    func getProfileForCurrentUser() {
        guard let currentUserID = AuthenticationService.getInstance.currentUser?.uid else {
            print("Fetching current user's profile: No signed in user found")
            return
        }
        self.profileService.fetchProfileByUserID(userID: currentUserID)
    }
    
    
    // Create a new profile
    func createProfile(_ fullName: String, _ address: String, _ birthday: String, _ bloodType: String, _ illness: String,_ allergies: String, _ avatar: String) {
        
        let currentUserID = AuthVM.authService.currentUser!.uid
        
        // Generate private connectionCode
        var hasher = Hasher() ; hasher.combine(currentUserID)
        let connectionHash = String(hasher.finalize())
        
        let newProfile = ProfileModel(userId: currentUserID, fullName: fullName, address: address, birthday: birthday, bloodType: bloodType, illness: illness, allergies: allergies, connectionCode: connectionHash, avatar: avatar)
        
        self.profileService.createProfile(newProfile: newProfile)
        
        self.getProfileForCurrentUser() // update app state
    }
    
    
}
