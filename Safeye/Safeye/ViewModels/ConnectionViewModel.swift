//
//  ConnectionViewModel.swift
//  Safeye
//
//  Created by Safeye team on 6.4.2022.


/*
        This class is handling connection/trusted contacts related functionalities.
        Mainly communicating with app state and vaious services that in turn communicates with the database and stores retrieved data in app state
 
        1. Filtering and return a specific connection's of pending request (recieved/sent) profile from app state, reurns the profile if exists, otherwise nil
        2. Getting a specific profile id of established connection (trusted contact)
        3. Deleting a specific connection, used to delete a stablished connection or to reject a pending request
        4. Accepting a recieved pending request that was sent by another user using current users connection code
        5. Getting current user's pending requests (sent and recieved)
        6. Getting profiles of trusted contacts (stablished connections)
        7. Getting pending connection request profiles. request sent by authenticated user
        8. Getting pending connection request profiles. request sent by other users to authenticated user
        9. Get established connection's details
        10. Sending a new connection request: User searches for a by using connection code of target user
 */


import Foundation
import Firebase
import SwiftUI

class ConnectionViewModel: ObservableObject {
    static let shared = ConnectionViewModel() ;  private init() {}
    private var connService = ConnectionService.shared
    private var profileService = ProfileService.shared
    @ObservedObject var appState = Store.shared
    var translationManager = TranslationService.shared
    
    // to filter specific connection profile from appState
    func filterConnectionProfileFromAppState(_ connection: ConnectionModel, established: Bool = false, recieved: Bool = false, sent: Bool = false) -> ProfileModel? {
        
        guard let currentUserID = AuthenticationService.getInstance.currentUser?.uid else { return nil }
        
        let trustedContactProfileId = connection.connectionUsers.filter { $0 != currentUserID }[0]
        if established && !self.appState.connectionPofiles.isEmpty {
            return self.appState.connectionPofiles.filter { $0.userId == trustedContactProfileId }[0]
        } else if recieved && !self.appState.pendingConnectionRequestProfilesTarget.isEmpty {
            return self.appState.pendingConnectionRequestProfilesTarget.filter { $0.userId == trustedContactProfileId }[0]
        } else if sent && !self.appState.pendingConnectionRequestProfilesOwner.isEmpty {
            return self.appState.pendingConnectionRequestProfilesOwner.filter { $0.userId == trustedContactProfileId }[0]
        } else { return nil }
    }
    
    
    // Get a specific profile id of established connection (trusted contact)
    func getConnectionProfileID(of connection: ConnectionModel) -> String {
        guard let currentUserID = AuthenticationService.getInstance.currentUser?.uid else { return "" }
        return connection.connectionUsers.filter { $0 != currentUserID }[0]
    }
    
    
    // Delete a specific connection
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
    
    
    // Accept a pending connection request sent by another user
    func confirmConnectionRequest(confirmedRequest: ConnectionModel) {
        withAnimation {
            DispatchQueue.main.async {
                var confirmedRequest = confirmedRequest ; confirmedRequest.status = true
                self.appState.pendingConnectionRequestsTarget = self.appState.pendingConnectionRequestsTarget.filter { $0.id != confirmedRequest.id }
                self.connService.confirmConnectionRequest(confirmedRequest)
            }
        }
    }

    
    // Fetch current user's pending requests
    func getPendingRequests()  {
        DispatchQueue.main.async {
            guard let currentUserID = AuthenticationService.getInstance.currentUser?.uid else { return }
            self.connService.fetchPendingConnectionRequests(currentUserID)
        }
    }
    
    
    // Get established connection profiles
    func getConnectionProfiles() {
        DispatchQueue.main.async {
            guard let currentUserID = AuthenticationService.getInstance.currentUser?.uid else { return }
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
            guard let currentUserID = AuthenticationService.getInstance.currentUser?.uid else { return }
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
            guard let currentUserID = AuthenticationService.getInstance.currentUser?.uid else { return }
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
    
    
    // Get established connection's details
    func getConnections() {
        DispatchQueue.main.async {
            guard let currentUserID = AuthenticationService.getInstance.currentUser?.uid else { return }
            self.connService.fetchConnections(currentUserID)
        }
    }

    
   // Send a new connection request
    func addConnection() -> String? {
        guard let currentUserID = AuthenticationService.getInstance.currentUser?.uid else { return nil }
        
        var message: String? = nil
        var canAdd = true

        guard let targetProfileID = self.appState.profileSearch?.userId else {
//            message = "User not found"
            message = "\(translationManager.userNotFound)"
            canAdd = false
            return message
        }

        if targetProfileID == appState.profile!.userId {
//            message = "You cannot add yourself"
            message = "\(translationManager.cantAddYourself)"
            canAdd = false
        }
        
        // USer already have connection request, do not allow to send a new one
        for connection in self.appState.connections {
            for userID in connection.connectionUsers {
                if userID == targetProfileID {
//                    message = "This connection already exists."
                    message = "\(translationManager.connectionAlreadyExists)"
                    canAdd = false
                }
            }
        }
        
        
        // User has already sent a connection request (pending), do not allow to send a new one
        for connectionSentByCurrentUser in self.appState.pendingConnectionRequestsOwner {
            if connectionSentByCurrentUser.connectionUsers[1] == targetProfileID {
//                message = "You have sent a request to this user."
                message = "\(translationManager.requestAlreadySent)"
                canAdd = false
            }
        }
        
        // User has already received a connection request (pending), do not allow to send a new one
        for connectionSentToCurrentUser in self.appState.pendingConnectionRequestsTarget {
            if connectionSentToCurrentUser.connectionUsers[1] == currentUserID {
//                message = "You have recieved a request by this user."
                message = "\(translationManager.requestAlreadyRecieved)"
                canAdd = false
            }
        }
        

        DispatchQueue.main.async {
            // generate a connection ID
            var hasher = Hasher()
            hasher.combine(currentUserID)
            hasher.combine(targetProfileID)
            let connectionId = String(hasher.finalize())

            let newConn = ConnectionModel(connectionId: connectionId, connectionUsers: [currentUserID, targetProfileID], status: false)

            // returns a boolean, was added or not?
            if canAdd {
                if self.connService.addConnection(newConn: newConn) {
//                    message = "Connection request sent successfully."
                    message = "\(self.translationManager.connectionReqSuccesess)"

                } else {
//                    message = "An error occured while sending a connection request."
                    message = "\(self.translationManager.errorConnectionReq)"

                }
            }
        }
        
        return message
    }
    
} // end of ConnectionVM
