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
    private var appState = Store.shared
    
    
    

    func getPendingRequests()  {
        let currentUserID = AuthenticationService.getInstance.currentUser!.uid
        self.connService.fetchPendingConnectionRequests(currentUserID)
    }
    
    func getConnectionProfiles() {
        let currentUserID = AuthenticationService.getInstance.currentUser!.uid
        self.appState.connectionPofiles.removeAll()
        self.getConnections()
        var connectionIDS = [String]()
        for connection in self.appState.connections {
            for userID in connection.connectionUsers {
                if !userID.value.isEmpty, userID.value != currentUserID { connectionIDS.append(String(userID.value)) }
            }
        }
        print("getConnectionProfiles -> Connection ids: fix -> Set -> distinquish: \(connectionIDS)")
        if !connectionIDS.isEmpty { self.connService.fetchConnectionProfiles(connectionIDS) }
    }
    
    func getConnections() {
        let currentUserID = AuthenticationService.getInstance.currentUser!.uid
        self.connService.fetchConnections(currentUserID)
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
                if userID.value == targetProfileID {
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
        
        let newConn = ConnectionModel(connectionId: connectionId, connectionUsers: ["owner": uid, "target": targetProfileID], status: false)
        
        // returns a boolean, was added or not?
        if connService.addConnection(newConn: newConn) {
            print("New connection added")
        } else {
            print("Adding new connection failed")
        }
    }
    
    
    
    
    
    
    
    
    
} // end of ConnectionVM
