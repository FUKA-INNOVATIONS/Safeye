//
//  ConnectionViewModel.swift
//  Safeye
//
//  Created by FUKA on 13.4.2022.
//

import Foundation
import Firebase
import SwiftUI

class ConnectionViewModel: ObservableObject {
    static let shared = ConnectionViewModel() ;  private init() {}
    private var connService = ConnectionService.shared
    private var profileService = ProfileService.shared
    @ObservedObject var appState = Store.shared
    
    func filterConnectionProfileFromAppState(_ connection: ConnectionModel, established: Bool = false, recieved: Bool = false, sent: Bool = false) -> ProfileModel? { // to filter specific connection profile from appState
        let trustedContactProfileId = connection.connectionUsers.filter { $0 != Store.shared.currentUserID }[0]
        if established && !self.appState.connectionPofiles.isEmpty {
            return self.appState.connectionPofiles.filter { $0.userId == trustedContactProfileId }[0]
        } else if recieved && !self.appState.pendingConnectionRequestProfilesTarget.isEmpty {
            return self.appState.pendingConnectionRequestProfilesTarget.filter { $0.userId == trustedContactProfileId }[0]
        } else if sent && !self.appState.pendingConnectionRequestProfilesOwner.isEmpty {
            return self.appState.pendingConnectionRequestProfilesOwner.filter { $0.userId == trustedContactProfileId }[0]
        } else { return nil }
    }
    
    func getConnectionProfileID(of connection: ConnectionModel) -> String {
        connection.connectionUsers.filter { $0 != Store.shared.currentUserID }[0]
    }
    
    
    func deleteConnection(_ connectionID: String, _ type: String) {
        withAnimation {
            DispatchQueue.main.async {
                self.connService.deleteConnection(connectionID)
                if type == "established" {
                    self.appState.connections = self.appState.connections.filter { $0.id != connectionID }
                } else {
                    self.appState.pendingConnectionRequestsOwner = self.appState.pendingConnectionRequestsOwner.filter { $0.id != connectionID }
                }
            }
        }
    }
    
    func confirmConnectionRequest(confirmedRequest: ConnectionModel) {
        withAnimation {
            DispatchQueue.main.async {
                var confirmedRequest = confirmedRequest ; confirmedRequest.status = true
                self.appState.pendingConnectionRequestsTarget = self.appState.pendingConnectionRequestsTarget.filter { $0.id != confirmedRequest.id }
                self.connService.confirmConnectionRequest(confirmedRequest)
            }
        }
    }

    func getPendingRequests()  {
        DispatchQueue.main.async {
            let currentUserID = Store.shared.currentUserID
            self.connService.fetchPendingConnectionRequests(currentUserID)
        }
    }
    
    // get confirmed connection profiles
    func getConnectionProfiles() {
        DispatchQueue.main.async {
            let currentUserID = Store.shared.currentUserID
            var connectionIDS = [String]()
            
            for connection in self.appState.connections {
                for userID in connection.connectionUsers {
                    if !userID.isEmpty, userID != currentUserID { connectionIDS.append(String(userID)) }
                }
            }
            print("getConnectionProfiles -> Connection ids: fix -> Set -> distinquish: \(connectionIDS)")
            if !connectionIDS.isEmpty { self.connService.fetchConnectionProfiles(connectionIDS) }
        }
    }
    
    // get pending connection request profiles. request sent by authenticated user
    func getProfilesOfPendingConectionRequestsSentByCurrentUser() {
        DispatchQueue.main.async {
            let currentUserID = Store.shared.currentUserID
            var connectionIDS = [String]()
            
            for connection in self.appState.pendingConnectionRequestsOwner {
                for userID in connection.connectionUsers {
                    if !userID.isEmpty, userID != currentUserID { connectionIDS.append(String(userID)) }
                }
            }
            print("getConnectionProfiles -> Connection ids: fix -> Set -> distinquish: \(connectionIDS)")
            if !connectionIDS.isEmpty { self.connService.fetchProfilesOfPendingConectionRequests(connectionIDS, sent: true) }
        }
    }
    
    // get pending connection request profiles. request sent by other users to authenticated user
    func getProfilesOfPendingConectionRequestsSentToCurrentUser() {
        DispatchQueue.main.async {
            let currentUserID = Store.shared.currentUserID
            var connectionIDS = [String]()
            
            for connection in self.appState.pendingConnectionRequestsTarget {
                for userID in connection.connectionUsers {
                    if !userID.isEmpty, userID != currentUserID { connectionIDS.append(String(userID)) }
                }
            }
            print("getConnectionProfiles -> Connection ids: fix -> Set -> distinquish: \(connectionIDS)")
            if !connectionIDS.isEmpty { self.connService.fetchProfilesOfPendingConectionRequests(connectionIDS, recieved: true) }
        }
    }
    
    
    func getConnections() { // established connections
        DispatchQueue.main.async {
            let currentUserID = Store.shared.currentUserID
            self.connService.fetchConnections(currentUserID)
        }
    }

   
    func addConnection() -> String? {
        var message: String? = nil
        var canAdd = true

        guard let targetProfileID = self.appState.profileSearch?.userId else {
            message = "User not found"
            canAdd = false
            return message
        }

        if targetProfileID == appState.profile!.userId {
            message = "You cannot add yourself"
            canAdd = false
            //return message
        }

        DispatchQueue.main.async {
            for connection in self.appState.connections {
                for userID in connection.connectionUsers {
                    if userID == targetProfileID {
                        message = "This connection already exists."
                        canAdd = false
                    }
                }
            }

            // generate a connection ID
            let uid = Store.shared.currentUserID
            var hasher = Hasher()
            hasher.combine(Store.shared.currentUserID)
            hasher.combine(targetProfileID)
            let connectionId = String(hasher.finalize())

            let newConn = ConnectionModel(connectionId: connectionId, connectionUsers: [uid, targetProfileID], status: false)

            // returns a boolean, was added or not?
            if canAdd {
                if self.connService.addConnection(newConn: newConn) {
                    message = "Connection request sent successfully."
                } else {
                    message = "An error occured while sending a connection request."
                }
            }
        }
        
        return message
    }
    
} // end of ConnectionVM
