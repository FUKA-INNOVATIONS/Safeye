//
//  ProfileViewModel.swift
//  Safeye
//
//  Created by Safeye Team on 1.4.2022.


import Foundation
import SwiftUI
import CoreLocation

class ProfileViewModel: NSObject, ObservableObject {
    static let shared = ProfileViewModel() ; private override init() {}
    let profileService = ProfileService.shared
    var AuthVM = AuthenticationViewModel.shared
    var appState = Store.shared
    
    func updateProfile(_ fullName: String, _ address: String, _ birthday: String, _ bloodType: String, _ illness: String, _ allergies: String, _ avatar: String) {
        guard let profileID = self.appState.profile?.id else {
            print("updateProfile -> profile id not found in app state")
            return
        }
        self.profileService.updateProfile(profileID, fullName, address, birthday, bloodType, illness, allergies, avatar)
        self.getProfileForCurrentUser() // update app state
    }
    
    func updateUserHomeCoordinates() {
        guard let profileID = self.appState.profile?.id else {
            print("updateProfile -> profile id not found in app state")
            return
        }
        let locationManager = CLLocationManager()
        self.profileService.updateUserHomeLocationCoordinates(profileID, [locationManager.location!.coordinate.latitude, locationManager.location!.coordinate.longitude])
    }
    
    func  getProfileByConnectionCode(withCode connectionCode: String) {
        self.profileService.fetchProfileByConnectionCode(connCode: connectionCode)
    }
    
    
    func getProfileForCurrentUser() {
        guard let currentUserID = AuthenticationService.getInstance.currentUser?.uid else {
            print("Fetching current user's profile: No signed in user found")
            return
        }
        self.profileService.fetchProfileByUserID(userID: currentUserID)
    }
    
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
