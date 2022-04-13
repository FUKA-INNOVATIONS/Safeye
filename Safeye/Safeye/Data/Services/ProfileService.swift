//
//  ProfileService.swift
//  Safeye
//
//  Created by FUKA on 1.4.2022.
//  EDited by FUKA 8.4.2022.
//  Edited by FUKA


import Foundation
import Firebase // Import firebase


// TODO: Database is in test mode, set rules and change to production mode
// TODO: move connection related code to own service








class ProfileService {
    static let instance = ProfileService() ;  private init() {}
    static let getInstance = Firestore.firestore() // Get instance of Firestore database
    private var profileDB = Firestore.firestore().collection("profiles")
    
    var profiles: [ProfileModel] = [ProfileModel]()
    // var profiles: Set<ProfileModel> = Set<ProfileModel>()
    
    func getProfiles() -> [ProfileModel]? {
        return self.profiles
    }
    
    func fetchProfiles(for userIds: [String]) {
        // var users = ["gJFO91ZLJTabKfU5QH0HcuaZ2Uj1", "td8IykGIgAgjbwgN8Po3zilnNOj2"]
        
        
        for id in userIds {
            profileDB.whereField("userId", isEqualTo: id).getDocuments() {  (profiles, error) in
                if let error = error {
                    print("Error getting single profile: \(error)")
                } else {
                    if profiles!.count < 1 {
                        print("no profile")
                        return
                    }
                    for profile in profiles!.documents {
                        // print("single profile: \(profile.data()["fullName"] ?? "")")
                    
                        let document = profile.data()
                        
                        let profileId = profile.documentID
                        let userId = document["userId"]
                        let fullName = document["fullName"]
                        let address = document["address"]
                        let birthday = document["birthday"]
                        let bloodType = document["bloodType"]
                        let illness = document["illness"]
                        let allergies = document["allergies"]
                        let connectionCode = document["connectionCode"]
                    
                        let temProfile = ProfileModel(id: profileId, userId: userId as! String, fullName: fullName as! String, address: address as! String, birthday: birthday as! String, bloodType: bloodType as! String, illness: illness as! String, allergies: allergies as! String, connectionCode: connectionCode as! String)
                        
                        // self.profiles.insert(temProfile)
                        self.profiles.append(temProfile)
                        // print("SINGLE: \(temProfile.fullName)")
                    }
                }
            }
        }
        
        // print("docs: \(docs)")
        // return nil
    }
    
}


































/*
class ProfileService {
    static let getInstance = Firestore.firestore() // Get instance of Firestore database
    private var profileDB = Firestore.firestore().collection("profiles")
    
    private var profileFound = false
    private var connectionProfileFound = false
    // @Published var profileConnection: ProfileModel?
    
    private var profiles: [ProfileModel] = [ProfileModel]()
    private var profileDetails: ProfileModel?
    
    
    func getProfileByConnectionCode(connCode: String) -> (Bool, ProfileModel?) {
        print("RRRRRR: \(self.connectionProfileFound) --- \(self.profileFound)")
        self.fetchProfileByConnectionCode(connCode: connCode)
        if self.connectionProfileFound {
            let response = (true, self.profileDetails)
            print("res: \(response)")
            return (true, self.profileDetails)
        } else {
            return (false, nil)
        }
    }
    
    
    
    
    func fetchProfile(profileID: String) { // Fetch profile by id
        profileDB.document(profileID).getDocument { profile, error in
            if let error = error as NSError? {
                print("profileService: Error fetching single profile: \(error.localizedDescription)")
            }
            else {
                if let profile = profile {
                    DispatchQueue.main.async {
                        do {
                            self.profileFound = true
                            self.profileDetails = try profile.data(as: ProfileModel.self)
                            print("Fetched profile: \(String(describing: profile.data()))")
                        }
                        catch {
                            print(error)
                        }
                    }
                }
            }
        }
    }
    
    
    func fetchProfileByConnectionCode(connCode: String) { // Fetch profile by connectionCode
        profileDB.whereField("connectionCode", isEqualTo: connCode).getDocuments() { profiles, error in
            if let error = error as NSError? {
                print("profileService: Error fetching  profile by connection code: \(error.localizedDescription)")
            }
            else {
                
                if profiles!.documents.count < 1 { self.connectionProfileFound = false ; print ("Connection profile not found") ; return }
                
                for profile in profiles!.documents {
                    //DispatchQueue.main.async {
                        do {
                            self.connectionProfileFound = true
                            //print("BOBOBOBOBO: \(self.connectionProfileFound)")
                            self.profileDetails = try profile.data(as: ProfileModel.self)
                            //print("Fetched profile: \(String(describing: profile.data()))")
                        }
                        catch {
                            print(error)
                        }
                    //}
                }
            }
        }
        
    }
    
    
} // end of ProfileService
*/
