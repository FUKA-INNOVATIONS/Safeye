//
//  ProfileViewModel.swift
//  Safeye
//
//  Created by FUKA on 1.4.2022.
//  Edit by FUKA on 8.4.2022.
// Edit by gintare on 10.4.2022.

import Foundation
import SwiftUI

class ProfileViewModel: ObservableObject {
    static let shared = ProfileViewModel() ; private init() {}
    let profileService = ProfileService.shared
    var AuthVM = AuthenticationViewModel.shared
    var appState = Store.shared
    
    func updateProfile(_ fullName: String, _ address: String, _ birthday: String, _ bloodType: String, _ illness: String, _ allergies: String) {
        guard let profileID = self.appState.profile?.id else {
            print("updateProfile -> profile id not found in app state")
            return
        }
        self.profileService.updateProfile(profileID, fullName, address, birthday, bloodType, illness, allergies)
        self.getProfileForCurrentUser() // update app state
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
    
    func createProfile(_ fullName: String, _ address: String, _ birthday: String, _ bloodType: String, _ illness: String,_ allergies: String) {
        
        let currentUserID = AuthVM.authService.currentUser!.uid
        
        // Generate private connectionCode
        var hasher = Hasher() ; hasher.combine(currentUserID)
        let connectionHash = String(hasher.finalize())
        
        let newProfile = ProfileModel(userId: currentUserID, fullName: fullName, address: address, birthday: birthday, bloodType: bloodType, illness: illness, allergies: allergies, connectionCode: connectionHash)
        
        self.profileService.createProfile(newProfile: newProfile)
        
        self.getProfileForCurrentUser() // update app state
    }
    
    
}
