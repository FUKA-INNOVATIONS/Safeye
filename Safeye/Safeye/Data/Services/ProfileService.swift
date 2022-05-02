//
//  ProfileService.swift
//  Safeye
//
//  Created by Safeye team on 1.4.2022.
//

/*
    Service which handles communication with the database and app state for the functionalities
    withing the ProfileViewModel. Handles creating/updating/retrieving  of user profiles
 
    1. Retrives the information about a users profile using the userId and stores it in app state
    2. Retrives profile information using connection code
    3. Creates new profile entry in database for current authenticated user
    4. Handles changes to profile information when a user wants to edit their own information
    5. Sets users home locations as their current coordinates, will be displayed for their trusted contacts
        as a safeSpace on their map
    6. Retrives the list of trusted contacts for an event and stores them in the app state
 */

import Foundation
import Firebase // Import firebase
import CoreLocation

class ProfileService {
    static let shared = ProfileService() ;  private init() {}
    private var profileDB = Firestore.firestore().collection("profiles")
    private var appState = Store.shared
    
    private var connectionProfileFound = false
    
    private var profiles: [ProfileModel] = [ProfileModel]()
    private var profileDetails: ProfileModel?

    // Retrives user profile by their Id
    func fetchProfileByUserID(userID: String, panicProfile: Bool = false) {
        DispatchQueue.main.async {
            self.profileDB.whereField("userId", isEqualTo: userID).addSnapshotListener()  { profile, error in
                if let error = error as NSError? {
                    print("profileService: Error fetching single profile: \(error.localizedDescription)")
                }
                else {
                    for profile in profile!.documents {
                        do {
                            if panicProfile {
                                self.appState.panicPofiles.append(try profile.data(as: ProfileModel.self))
                            } else {
                                self.appState.profile = try profile.data(as: ProfileModel.self)
                            }
                            print("Fetched profile: \(String(describing: profile.data()))")
                        }
                        catch {
                            print("Error on fetchProfileByID: \(error)")
                        }
                    }
                }
            }
        }
    }
    
    
    // Uses connection code to fetch user profile
    func fetchProfileByConnectionCode(connCode: String) {
        DispatchQueue.main.async {
            self.profileDB.whereField("connectionCode", isEqualTo: connCode).addSnapshotListener() { profiles, error in
                if let error = error as NSError? {
                    print("profileService: Error fetching  profile by connection code: \(error.localizedDescription)")
                }
                else {
                    
                    if profiles!.documents.isEmpty { self.connectionProfileFound = false ; print ("Connection profile not found") ; return }
                    
                    for profile in profiles!.documents {
                        do {
                            //self.connectionProfileFound = true
                            print("fetchProfileByConnectionCode: \(profile)")
                            self.appState.profileSearch = try profile.data(as: ProfileModel.self)
                        }
                        catch {
                            print("Error on fetchProfileByConnectionCode \(error)")
                        }
                    }
                }
            }
        }
    }
    
    
    
    func createProfile(newProfile: ProfileModel) {
        do {
            _ = try self.profileDB.addDocument(from: newProfile)
            // return true
        }
        catch {
            print("Error while creating new profile: \(error)")
            // return false
        }
    }
    
    
    // Updates the users profile base on changes in the for provided
    func updateProfile(_ profileID: String, _ fullName: String, _ address: String, _ birthday: String, _ bloodType: String, _ illness: String, _ allergies: String, _ avatar: String) {
        self.profileDB.document(profileID).setData(
            ["fullName" : fullName, "address" : address, "birthday" : birthday, "bloodType" : bloodType, "illness" : illness, "allergies" : allergies, "avatar" : avatar], merge: true) { error in
                
                //TODO:  Check for error, change it > pass whole object to update
                
                if error == nil {
                    // Get the new data and updtae app state
                    //self.getProfile() > not here
                }
            }
    }
    
    
    // Sets the current users location as their home coordinates
    func updateUserHomeLocationCoordinates(_ profileID: String, _ homeCoordinates: [Double]) {
        self.profileDB.document(profileID).updateData(["homeLatitude": homeCoordinates[0], "homeLongitude": homeCoordinates[1]]) { error in
            
            if error == nil {}
            
        }
    }
    
    
    // Retieve the profiles of the trusted contacts associated with an event
    func fetchEventTrustedContactsProfiles(_ userIDS: [String]) {
        DispatchQueue.main.async {
            self.profileDB.whereField("userId", in: userIDS).addSnapshotListener() { profiles, error in
                if let error = error {
                    print("ProfileService: Error getting profiles of trusted contacts: \(error)")
                } else {
                    self.appState.eventTrustedContactsProfiles.removeAll()
                    for profile in profiles!.documents {
                        print("TC profile: \(profile.documentID) => \(profile.data())")
                        do {
                            let convertedProfile = try profile.data(as: ProfileModel.self)
                            self.appState.eventTrustedContactsProfiles.append(convertedProfile)
                        } catch {
                            print("Error while converting event TC profiles: \(error)")
                        }
                    }
                }
            }
        }
    }
    
    
    
} // end of ProfileService
