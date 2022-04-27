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
    
    func filterConnectionProfileFromAppState(_ connection: ConnectionModel) -> ProfileModel? { // to filter specific connection profile from appState
        let trustedContactProfileId = connection.connectionUsers.filter { $0 != AuthenticationService.getInstance.currentUser!.uid }[0]
        if !self.appState.connectionPofiles.isEmpty {
            return self.appState.connectionPofiles.filter { $0.userId == trustedContactProfileId }[0]
        } else { return nil }
    }
    
    // filter profiles from appState of pending received requests
    func filterPendingReqProfileFromAppState(_ pendingReq: ConnectionModel) -> ProfileModel? {
        let trustedContactProfileId = pendingReq.connectionUsers.filter { $0 != AuthenticationService.getInstance.currentUser!.uid }[0]
        if !self.appState.pendingReqProfiles.isEmpty {
            return self.appState.pendingReqProfiles.filter { $0.userId == trustedContactProfileId }[0]
        } else { return nil }
    }
    
    // filter profiles from appState of sent requests
    func filterSentReqProfileFromAppState(_ sentReq: ConnectionModel) -> ProfileModel? {
        let trustedContactProfileId = sentReq.connectionUsers.filter { $0 != AuthenticationService.getInstance.currentUser!.uid }[0]
        if !self.appState.sentReqProfiles.isEmpty {
            return self.appState.sentReqProfiles.filter { $0.userId == trustedContactProfileId }[0]
        } else { return nil }
    }
    
    func getConnectionProfileID(of connection: ConnectionModel) -> String {
        connection.connectionUsers.filter { $0 != AuthenticationService.getInstance.currentUser!.uid }[0]
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
//            self.appState.pendingConnectionRequestsOwner.removeAll()  /** Empty app state **/
//            self.appState.pendingConnectionRequestsTarget.removeAll() /** Empty app state **/
            let currentUserID = AuthenticationService.getInstance.currentUser!.uid
            self.connService.fetchPendingConnectionRequests(currentUserID)
        }
    }
    
    // get connection profiles of pending received requests
    func getPendingReqProfiles() {
        let currentUserID = AuthenticationService.getInstance.currentUser!.uid
        var connectionIDS = [String]()
        for request in self.appState.pendingConnectionRequestsTarget {
            for userID in request.connectionUsers {
                if !userID.isEmpty, userID != currentUserID {
                    connectionIDS.append(String(userID))
                }
            }
        }
        if !connectionIDS.isEmpty { self.connService.fetchConnectionProfiles(connectionIDS, isPendingReq: true) }
    }
    
    // get connection profiles of sent requests
    func getSentReqProfiles() {
        let currentUserID = AuthenticationService.getInstance.currentUser!.uid
        var connectionIDS = [String]()
        for request in self.appState.pendingConnectionRequestsOwner {
            for userID in request.connectionUsers {
                if !userID.isEmpty, userID != currentUserID {
                    connectionIDS.append(String(userID))
                }
            }
        }
        if !connectionIDS.isEmpty { self.connService.fetchConnectionProfiles(connectionIDS, isSentReq: true) }
    }
    
    // get confirmed connection profiles
    func getConnectionProfiles() {
        let currentUserID = AuthenticationService.getInstance.currentUser!.uid
        var connectionIDS = [String]()
        
        for connection in self.appState.connections {
            for userID in connection.connectionUsers {
                if !userID.isEmpty, userID != currentUserID { connectionIDS.append(String(userID)) }
            }
        }
        print("getConnectionProfiles -> Connection ids: fix -> Set -> distinquish: \(connectionIDS)")
        if !connectionIDS.isEmpty { self.connService.fetchConnectionProfiles(connectionIDS) }
    }
    
    func getConnections() {
        DispatchQueue.main.async {
//            self.appState.connections.removeAll()
            let currentUserID = AuthenticationService.getInstance.currentUser!.uid
            self.connService.fetchConnections(currentUserID)
        }
    }


    func addConnection() {
        // TODO: Check, if user already have addded connection ? request exists ?
        // TODO: If successful this should trigger a notification sent to target user (Sprint 3?) ???
        
        guard let targetProfileID = self.appState.profileSearch?.userId else {
            print("addConnection -> Searched profile not found")
            return
        }
        
        for connection in self.appState.connections {
            for userID in connection.connectionUsers {
                if userID == targetProfileID {
                    print("You already have this connection as trusted conntact")
                    return
                }
            }
        }
        
        
        let uid = AuthenticationService.getInstance.currentUser!.uid
        var hasher = Hasher()
        hasher.combine(AuthenticationService.getInstance.currentUser!.uid)
        hasher.combine(targetProfileID)
        let connectionId = String(hasher.finalize())
        
        let newConn = ConnectionModel(connectionId: connectionId, connectionUsers: [uid, targetProfileID], status: false)
        
        // returns a boolean, was added or not?
        if connService.addConnection(newConn: newConn) {
            print("New connection added")
        } else {
            print("Adding new connection failed")
        }
    }
    
    
    
    
    
    
    
    
    
} // end of ConnectionVM
