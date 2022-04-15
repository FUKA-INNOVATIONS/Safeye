//
//  PlayGroundView.swift
//  Safeye
//
//  Created by FUKA on 13.4.2022.
//

import SwiftUI

struct PlayGroundView: View {
    @EnvironmentObject var ConnectionVM: ConnectionViewModel
    @EnvironmentObject var PlaygroundVM: PlaygroundViewModel
    @EnvironmentObject var appState: Store
    
    
    var body: some View {
        
        return VStack {
            BasicButtonComponent(label: "Fetch connection profiles") {
                
            }
            
            
            /* ForEach(self.appState.pendingRequests) { req in
                Text("Req: \(req.connectionId)")
            } */
            
            ForEach(self.appState.connectionPofiles) { profile in
                Text("Full name: \(profile.fullName)")
            }
            
            
            
            Text("Hello playground")
            Text("Event: \(self.appState.event?.otherInfo ?? "No info" )")
            
            
            VStack {
                /*ForEach(self.connService.pendingConnectionRequests) { req in
                    Text(req.connectionId)
                    
                }*/
            }
            
        }
        .task {
            print("Map view ")
        }
        .onAppear {
            
            let userID1 = "LJIziY424tfW1ZEwAzBwvhicaMb2"
            let userID2 = "td8IykGIgAgjbwgN8Po3zilnNOj2"
            self.ConnectionVM.getConnectionProfiles(for: [userID1, userID2])
            
            
            //self.ConnectionVM.getPendingREquests()
            //self.PlaygroundVM.getEvent("qGcGgDF8K3FvJjplNYP4")
        }
        
    }
}

