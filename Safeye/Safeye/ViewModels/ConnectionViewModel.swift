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
    var translationManager = TranslationService.shared
    
    func filterConnectionProfileFromAppState(_ connection: ConnectionModel, established: Bool = false, recieved: Bool = false, sent: Bool = false) -> ProfileModel? { // to filter specific connection profile from appState
        
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
    
    func getConnectionProfileID(of connection: ConnectionModel) -> String {
        guard let currentUserID = AuthenticationService.getInstance.currentUser?.uid else { return "" }
        return connection.connectionUsers.filter { $0 != currentUserID }[0]
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
            guard let currentUserID = AuthenticationService.getInstance.currentUser?.uid else { return }
            self.connService.fetchPendingConnectionRequests(currentUserID)
        }
    }
    
    // get confirmed connection profiles
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
    
    
    func getConnections() { // established connections
        DispatchQueue.main.async {
            guard let currentUserID = AuthenticationService.getInstance.currentUser?.uid else { return }
            self.connService.fetchConnections(currentUserID)
        }
    }

   
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
