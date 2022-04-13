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
    static let getInstance = Firestore.firestore() // Get instance of Firestore database
    private var profileDB = Firestore.firestore().collection("profiles")
    private var connectionsDB = Firestore.firestore().collection("connections")
    
    var profiles: [ProfileModel] = [ProfileModel]()
    var profileDetails: ProfileModel?
    private var PendingConnectionRequests = [ConnectionModel]()
    // var profiles: Set<ProfileModel> = Set<ProfileModel>()
    
    func getProfiles() -> [ProfileModel]? {
        return self.profiles
    }
    
    func getPendingRequests() -> [ConnectionModel] {
        self.fetchPendingConnectionRequests()
        print("RRRRR => \(self.PendingConnectionRequests)")
        return self.PendingConnectionRequests
    }
    
    
    
    func fetchConnectionProfiles(users: [String]) {
        self.profileDB.whereField("userId", in: users).getDocuments() { profiles, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for profile in profiles!.documents {
                    print("\(profile.documentID) => \(profile.data())")
                }
            }
        }
    } // end of fetchConnectionProfiles
    
    
    
    func addConnection(newConn: ConnectionModel) -> Bool {
        do {
            _ = try connectionsDB.addDocument(from: newConn)
            return true
        }
        catch {
            print(error)
            return false
        }
    }
    
    

    func fetchPendingConnectionRequests() {
        let currentUserId = AuthenticationService.getInstance.currentUser!.uid
        print("Current id: => \(currentUserId)")
        
        self.connectionsDB.whereField("connectionUsers.target", isEqualTo: currentUserId)
            .whereField("status", isEqualTo: false).getDocuments() { requests, error in
                
                if let error = error {
                    print("Error fetching connection requests \(error)")
                    return
                }
                else {
                    if requests!.count < 1 { print("There are no pending connection requests"); return }
                    if let requests = requests {
                        print("Pending connections: => \(requests.count)")
                        for request in requests.documents {
                            //print("req => \(request.data())")
                            do {
                                let convertedRequest = try request.data(as: ConnectionModel.self)
                                self.PendingConnectionRequests.append(convertedRequest)
                            } catch {
                                print(error)
                            }
                        }
                    }
                }
            }
    }
    
    
    func confirmConnectionRequest(requestID: String) {
        connectionsDB.document(requestID).setData(["status": true], merge: true) { error in
            if error == nil {
                print("Request confirmed")
            } else {
                print("Error confirming connection request")
            }
        }
    } // end of confirmConnectionRequest
    
    
    func fetchProfile(profileID: String) {
        profileDB.document(profileID).getDocument { profile, error in
            if let error = error as NSError? {
                print("profileService: Error fetching single profile: \(error.localizedDescription)")
            }
            else {
                if let profile = profile {
                    do {
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
    
    
    
} // end of ProfileService
