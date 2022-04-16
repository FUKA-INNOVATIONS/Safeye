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
    
    
    
    func fetchConnections (_ userID: String) {
        
        self.connectionsDB.whereField("connectionUsers.owner", isEqualTo: userID)
            .whereField("status", isEqualTo: true).getDocuments() { connections, error in
                if let error = error {
                    print("Error fetching connections \(error)")
                    return
                }
                else {
                    if connections!.isEmpty { print("There are no connections"); return }
                    if let connection = connections {
                        self.appStore.connections.removeAll()
                        print("rere: \(connection.metadata.hasPendingWrites)")
                        print("User connections: => \(connection.count)")
                        for connection in connection.documents {
                            DispatchQueue.main.async {
                                do {
                                    let convertedConection = try connection.data(as: ConnectionModel.self)
                                    self.appStore.connections.append(convertedConection)
                                } catch {
                                    print("Error while fetching connections: \(error)")
                                }
                            }
                        }
                    }
                }
            }
    }
    
    func fetchPendingConnectionRequests (_ userID: String) {
        
        self.connectionsDB.whereField("connectionUsers.target", isEqualTo: userID)
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
        self.appStore.connectionPofiles.removeAll()
        self.profileDB.whereField("userId", in: userIDS).getDocuments() { profiles, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for profile in profiles!.documents {
                    print("\(profile.documentID) => \(profile.data())")
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
