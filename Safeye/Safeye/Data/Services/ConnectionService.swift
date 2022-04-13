//
//  ConnectionService.swift
//  Safeye
//
//  Created by FUKA on 13.4.2022.
//

import Foundation
import Firebase

class ConnectionService {
    private var connectionsDB = Firestore.firestore().collection("connections")
    private var profileDB = Firestore.firestore().collection("profiles")
    
    private var PendingConnectionRequests = [ConnectionModel]()
    private var connectionProfiles: [ProfileModel]?
    
    var getPendingRequests: [ConnectionModel] {
        self.fetchPendingConnectionRequests()
        print("RRRRR => \(self.PendingConnectionRequests)")
        return self.PendingConnectionRequests
    }
    
    var getProfiles: [ProfileModel]? {
        return self.connectionProfiles
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
    
    func fetchProfiles(users: [String]) {
        self.profileDB.whereField("userId", in: users).getDocuments() { profiles, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for profile in profiles!.documents {
                    print("\(profile.documentID) => \(profile.data())")
                    // self.connectionProfiles?.append(profile)
                }
            }
        }
    } // end of fetchConnectionProfiles


} // end of ConnectionService
