//
//  PlayGroundView.swift
//  Safeye
//
//  Created by FUKA on 13.4.2022.
//

import SwiftUI

struct PlayGroundView: View {
    @EnvironmentObject var ConnectionVM: ConnectionViewModel
    @EnvironmentObject var appState: Store
    @EnvironmentObject var PlaygroundVM: PlaygroundViewModel
    
    
    
    var body: some View {
        VStack {
            BasicButtonComponent(label: "Fetch requests") {
                DispatchQueue.main.async {
                    self.ConnectionVM.getPendingREquests()
                    print("Count: \(self.ConnectionVM.pendingREquests.count)")
                }
            }
            
            BasicButtonComponent(label: "Update store via VM") {
                //self.PlaygroundVM.changeText(text: "New text")
                // self.appState.greeting = "ERERER"
                self.PlaygroundVM.changeText("Good day")
                
            }
            
            ForEach(self.appState.pendingRequests) { req in
                Text("Req: \(req.connectionId)")
            }
            
            Text("Hello playground")
            Text("Event")
            
            
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
            self.ConnectionVM.getPendingREquests()
            self.PlaygroundVM.getEvent("qGcGgDF8K3FvJjplNYP4")
        }
        
    }
}

