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
    private var appState = Store.shared
    private var connectionsDB = Firestore.firestore().collection("connections")
    private var profileDB = Firestore.firestore().collection("profiles")
    
    
    
    func fetchConnections (_ userID: String) {
        print("fetchConnections -> userID: \(userID)")
        DispatchQueue.main.async {
            self.connectionsDB.whereField("connectionUsers", arrayContains: userID)
                .whereField("status", isEqualTo: true).addSnapshotListener() { connections, error in
                    if let error = error {
                        print("Error fetching connections \(error)")
                        return
                    }
                    else {
                        if connections!.isEmpty { print("There are no connections"); return }
                        if let connections = connections {
                            self.appState.connections.removeAll()
                            print("fetchConnections metaData PendingWrites: \(connections.metadata.hasPendingWrites)")
                            print("fetchConnections > User connections: => \(connections.count)")
                            for connection in connections.documents {
                                    do {
                                        let convertedConection = try connection.data(as: ConnectionModel.self)
                                        self.appState.connections.append(convertedConection)
                                    } catch {
                                        print("fetchConnections > Error while fetching connections: \(error)")
                                    }
                            }
                        }
                    }
                }
        }
    }
    
    func fetchPendingConnectionRequests (_ userID: String) { // type: received= target / sent = owner
        DispatchQueue.main.async {
            self.connectionsDB.whereField("connectionUsers", arrayContains: userID)
                .whereField("status", isEqualTo: false).addSnapshotListener() { requests, error in
                    
                    if let error = error {
                        print("Error fetching connection requests \(error)")
                        return
                    }
                    else {
                        //if requests!.isEmpty { print("There are no pending connection requests"); return }
                        if let requests = requests {
                           
                            self.appState.pendingConnectionRequestsOwner.removeAll()  /** Empty app state **/
                            self.appState.pendingConnectionRequestsTarget.removeAll() /** Empty app state **/
                            
                            print("fetchPendingConnectionRequests: => \(requests.count)")
                            
                            for request in requests.documents {
                                    do {
                                        let convertedRequest = try request.data(as: ConnectionModel.self)
                                        //convertedRequest.id = request.documentID
                                        print("fetchPendingConnectionRequests \(convertedRequest)")
                                        if convertedRequest.connectionUsers[0] == userID { self.appState.pendingConnectionRequestsOwner.append(convertedRequest)
                                        } else {
                                            self.appState.pendingConnectionRequestsTarget.append(convertedRequest) }
                                    } catch {
                                        print("Error while fetching pending requests: \(error)")
                                    }
                            }
                        }
                    }
                }
        }
    }
    
    func confirmConnectionRequest(_ connectionRequest: ConnectionModel) {
        DispatchQueue.main.async {
            let connectionRef = self.connectionsDB.document(connectionRequest.id!)
            do {
                try connectionRef.setData(from: connectionRequest)
            }
            catch {
                print(error)
            }
        }
    }
    
    func deleteConnection(_ connectionID: String) {
        DispatchQueue.main.async {
            self.connectionsDB.document(connectionID).delete() { error in
                if let error = error {
                    print("Error deleting connection: \(error)")
                } else {
                    print("Connection successfully deleted!")
                }
            }
        }
    }
    
    
    // Add user as trusted contact and create a new entry in 'connections' collection
    func addConnection(newConn: ConnectionModel) -> Bool { // TODO: FIX > check for existing connection, add only if not exist
        var didAdd = false
        DispatchQueue.main.async {
            do {
                _ = try self.connectionsDB.addDocument(from: newConn)
                didAdd = true
            }
            catch {
                print(error)
                didAdd = false
            }
        }
        return didAdd
    }
    
    func fetchConnectionProfiles(_ userIDS: [String], eventCase: Bool = false) {
        DispatchQueue.main.async {
            eventCase ? self.appState.currentEventTrustedContacts.removeAll() : self.appState.connectionPofiles.removeAll()
            
            self.profileDB.whereField("userId", in: userIDS).addSnapshotListener() { profiles, error in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    for profile in profiles!.documents {
                        print("\(profile.documentID) => \(profile.data())")
                            do {
                                let convertedProfile = try profile.data(as: ProfileModel.self)
                                if eventCase {
                                    self.appState.currentEventTrustedContacts.append(convertedProfile)
                                }
                                else {
                                    self.appState.connectionPofiles.append(convertedProfile)
                                }
                            } catch {
                                print("Error while converting connection profiles: \(error)")
                            }
                    }
                }
            }
        }
    }
    
    // Fetch profiles of pending connection request's users
    func fetchProfilesOfPendingConectionRequests(_ userIDS: [String], sent: Bool = false, recieved: Bool = false) {
        DispatchQueue.main.async {
            if sent { self.appState.pendingConnectionRequestProfilesOwner.removeAll() }
            if recieved { self.appState.pendingConnectionRequestProfilesTarget.removeAll() }
            
            self.profileDB.whereField("userId", in: userIDS).addSnapshotListener() { profiles, error in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    for profile in profiles!.documents {
                        print("\(profile.documentID) => \(profile.data())")
                            do {
                                let convertedProfile = try profile.data(as: ProfileModel.self)
                                if sent { self.appState.pendingConnectionRequestProfilesOwner.append(convertedProfile) }
                                if recieved { self.appState.pendingConnectionRequestProfilesTarget.append(convertedProfile) }
                            } catch {
                                print("Error while converting pending connections profiles profiles: \(error)")
                            }
                    }
                }
            }
        }
    }
    
    


} // end of ConnectionService
