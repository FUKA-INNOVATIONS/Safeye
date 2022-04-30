//
//  ProfileService.swift
//  Safeye
//
//  Created by FUKA on 1.4.2022.
//  EDited by FUKA 8.4.2022.
//  Edited by FUKA


import Foundation
import Firebase // Import firebase
import CoreLocation


// TODO: Database is in test mode, set rules and change to production mode
// TODO: move connection related code to own service


class ProfileService {
    static let shared = ProfileService() ;  private init() {}
    private var profileDB = Firestore.firestore().collection("profiles")
    private var appState = Store.shared
    
    private var connectionProfileFound = false
    
    private var profiles: [ProfileModel] = [ProfileModel]()
    private var profileDetails: ProfileModel?

    
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
    
    func updateUserHomeLocationCoordinates(_ profileID: String, _ homeCoordinates: [Double]) {
        self.profileDB.document(profileID).updateData(["homeLatitude": homeCoordinates[0], "homeLongitude": homeCoordinates[1]]) { error in
            
            if error == nil {}
            
        }
    }
    
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
