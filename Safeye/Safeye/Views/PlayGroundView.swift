//
//  PlayGroundView.swift
//  Safeye
//
//  Created by FUKA on 13.4.2022.
//

import SwiftUI

struct PlayGroundView: View {
    @EnvironmentObject var ConnectionVM: ConnectionViewModel
    @ObservedObject var connService = ConnectionService.instance
    
    
    var body: some View {
        VStack {
            BasicButtonComponent(label: "Fetch requests") {
                DispatchQueue.main.async {
                    self.ConnectionVM.getPendingREquests()
                    print("Count: \(self.ConnectionVM.pendingREquests.count)")
                }
            }
            
            Text("Hello playgroung")
            
            
            VStack {
                ForEach(self.connService.pendingConnectionRequests) { req in
                    Text(req.connectionId)
                    
                }
            }
            
        }
        .task {
            print("Map view")
        }
        .onAppear {
            self.ConnectionVM.getPendingREquests()
        }
        
    }
}

