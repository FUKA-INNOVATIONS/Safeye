//
//  ConnectionService.swift
//  Safeye
//
//  Created by FUKA on 13.4.2022.
//

import Foundation
import Firebase
import SwiftUI

class ConnectionService: ObservableObject {
    static let shared = ConnectionService() ; private init() {}
    private var appStore = Store.shared
    private var connectionsDB = Firestore.firestore().collection("connections")
    private var profileDB = Firestore.firestore().collection("profiles")
    
    
    func fetchPendingConnectionRequests () {
        let currentUserId = AuthenticationService.getInstance.currentUser!.uid
        print("Current id: => \(currentUserId)")
        
        self.connectionsDB.whereField("connectionUsers.target", isEqualTo: currentUserId)
            .whereField("status", isEqualTo: false).getDocuments() { requests, error in
                
                
                if let error = error {
                    print("Error fetching connection requests \(error)")
                    return
                }
                else {
                    if requests!.isEmpty { print("There are no pending connection requests"); return }
                    if let requests = requests {
                        self.appStore.pendingRequests.removeAll()
                        print("rere: \(requests.metadata.hasPendingWrites)")
                        print("Pending connections: => \(requests.count)")
                        for request in requests.documents {
                            DispatchQueue.main.async {
                                do {
                                    let convertedRequest = try request.data(as: ConnectionModel.self)
                                    self.appStore.pendingRequests.append(convertedRequest)
                                } catch {
                                    print("Error while fetching pending requests: \(error)")
                                }
                            }
                        }
                    }
                }
            }
        print("Store -> pending requests: \(self.appStore.pendingRequests.count)")
    }
    
    func confirmConnectionRequest(requestID: String) {
        connectionsDB.document(requestID).setData(["status": true], merge: true) { error in
            if error == nil {
                print("Request confirmed")
            } else {
                print("Error confirming connection request")
            }
        }
    }
    
    
    // Add user as trusted contact and create a new entry in 'connections' collection
    func addConnection(newConn: ConnectionModel) -> Bool { // TODO: FIX > check for existing connection, add only if not exist
        do {
            _ = try connectionsDB.addDocument(from: newConn)
            return true
        }
        catch {
            print(error)
            return false
        }
    }
    
    func fetchConnectionProfiles(_ userIDS: [String]) {
        self.profileDB.whereField("userId", in: userIDS).getDocuments() { profiles, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for profile in profiles!.documents {
                    print("\(profile.documentID) => \(profile.data())")
                    self.appStore.connectionPofiles.removeAll()
                    DispatchQueue.main.async {
                        do {
                            let convertedProfile = try profile.data(as: ProfileModel.self)
                            self.appStore.connectionPofiles.append(convertedProfile)
                        } catch {
                            print("Error while converting connection profiles: \(error)")
                        }
                    }
                }
            }
        }
    }
    
    


} // end of ConnectionService
