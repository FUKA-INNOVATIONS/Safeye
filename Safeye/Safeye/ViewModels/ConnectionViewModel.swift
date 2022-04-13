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
    static let instance = ConnectionViewModel() ;  private init() {}
    @Published var connService = ConnectionService.instance
    
    @Published var profileFound = false
    @Published var connectionFound = false
    
    @Published var pendingREquests: [ConnectionModel] = []
    
    func getPendingREquests()  {
            DispatchQueue.main.async {
                self.pendingREquests = self.connService.getPendingRequests()
            }
    }


    func addConnection(_ targetID: String) {
        let uid = AuthenticationService.getInstance.currentUser!.uid
        var hasher = Hasher()
        hasher.combine(AuthenticationService.getInstance.currentUser!.uid)
        hasher.combine(targetID)
        let connectionId = String(hasher.finalize())
        
        let newConn = ConnectionModel(connectionId: connectionId, connectionUsers: ["Owner": uid, "target": targetID], status: false)
        
        if connService.addConnection(newConn: newConn) {
            print("New connection added")
        } else {
            print("Adding new connection failed")
        }
    }
    
    
    
    
    
    
    
} // end of ConnectionVM
