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
    var connService = ConnectionService.shared
    
    
    @Published var profileFound = false
    @Published var connectionFound = false
    
    @Published var pendingREquests: [ConnectionModel] = []
    
    func getPendingRequests()  {
        self.connService.fetchPendingConnectionRequests()
    }
    
    func getConnectionProfiles(for userIDS: [String]) {
        self.connService.fetchConnectionProfiles(userIDS)
    }


    func addConnection(_ targetID: String) {
        // TODO: Check, dows user already have addded connection ? request exists ?
        // TODO: If successful this should trigger a notification sent to target user (Sprint 3?) ???
        
        let uid = AuthenticationService.getInstance.currentUser!.uid
        var hasher = Hasher()
        hasher.combine(AuthenticationService.getInstance.currentUser!.uid)
        hasher.combine(targetID)
        let connectionId = String(hasher.finalize())
        
        let newConn = ConnectionModel(connectionId: connectionId, connectionUsers: ["Owner": uid, "target": targetID], status: false)
        
        // returns a boolean, was added or not?
        if connService.addConnection(newConn: newConn) {
            print("New connection added")
        } else {
            print("Adding new connection failed")
        }
    }
    
    
    
    
    
    
    
    
    
} // end of ConnectionVM
