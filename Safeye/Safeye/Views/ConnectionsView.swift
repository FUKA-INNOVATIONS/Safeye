//
//  ConnectionsView.swift
//  Safeye
//
//  Created by FUKA on 18.4.2022.
//

import SwiftUI

struct ConnectionsView: View {
    @EnvironmentObject var ConnectionVM: ConnectionViewModel
    @EnvironmentObject var appState: Store
    
    
    var body: some View {
        VStack {
            
            Form {
                
                Section("Connections") {
                    ForEach(appState.connections) { connection in
                        // let _ = self.appState.connectionPofiles.filter { $0.userId == connection.connectionUsers[1] }
                        HStack {
                            Image(systemName: "trash")
                            Text("Full name")
                            Spacer()
                            Text("profile")
                            Image(systemName: "eye")
                        }
                    }
                    
                }
                
                Section("Received requests") {
                    ForEach(appState.pendingConnectionRequestsTarget) { request in
                        HStack {
                            Button {
                                ConnectionVM.confirmConnectionRequest(confirmedRequest: request)
                            } label: {
                                Text("Tap")
                            }

                            Text("Full name")
                            Spacer()
                            Group {
                                Text("accept")
                                Image(systemName: "hand.thumbsup.fill")
                            }
                            .foregroundColor(.green)
                        }
                    }
                }
                
                Section("Sent requests") {
                    ForEach(appState.pendingConnectionRequestsOwner) { request in
                        HStack {
                            Text("Full name")
                            Spacer()
                            Group {
                                Text("cancel")
                                Image(systemName: "hand.raised.slash.fill")
                            }
                            .foregroundColor(.red)
                        }
                    }
                }
                
            }

        }
        .onAppear {
            ConnectionVM.getConnections()
            ConnectionVM.getConnectionProfiles()
            ConnectionVM.getPendingRequests()
        }
    }
}

struct ConnectionsView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionsView()
    }
}
