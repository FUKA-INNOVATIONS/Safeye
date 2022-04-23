//
//  ConnectionsView.swift
//  Safeye
//
//  Created by FUKA on 18.4.2022.
//

import SwiftUI

struct ConnectionsView: View {
    @EnvironmentObject var ConnectionVM: ConnectionViewModel
    @EnvironmentObject var ProfileVM: ProfileViewModel
    @EnvironmentObject var FileVM: FileViewModel
    @EnvironmentObject var appState: Store
    @State var showingConnectionProfile = false
    
    var body: some View {
        VStack {
            
            Form {
                
                Section("Connections") {
                    ForEach(appState.connectionProfilesWithAvatars) { connection in
                        // _ = ConnectionVM.filterConnectionProfileFromAppState(connection)
                        Button { ConnectionVM.deleteConnection(connection.userId) } label: { Image(systemName: "trash").foregroundColor(.red) }
                        HStack {
                            Image(systemName: "trash")
                            Text(connection.fullName)
                            Spacer()
                            Text("profile")
                            Button {
                                showingConnectionProfile = true
                                FileVM.fetchPhoto(avatarUrlFetched: connection.avatar, isTrustedContactPhoto: true)
                                ProfileVM.getTrustedContactProfile(trustedContactID: connection.userId)

                            } label: { Image(systemName: "eye") }
                        }
                        .sheet(isPresented: $showingConnectionProfile) {
                            //ProfileView(profileID: connection.id!)
                            TrustedContactProfileView(profileID: connection.userId)
                            
                        }
                        //.background( NavigationLink(destination: ProfileView(profileID: connection.id!), isActive: $goConnectionProfile) { EmptyView() }.hidden() )
                    }
                    
                }
                
                Section("Received requests") {
                    ForEach(appState.pendingConnectionRequestsTarget) { request in
                        HStack { Button { ConnectionVM.confirmConnectionRequest(confirmedRequest: request)} label: {Text("")}
                            
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
                                Button { ConnectionVM.deleteConnection(request.id!) } label: { Image(systemName: "hand.raised.slash.fill").foregroundColor(.red) }
                            }
                            .foregroundColor(.red)
                        }
                    }
                }
                
            }
            
        }
        .onAppear {
            ConnectionVM.getConnections()
            ConnectionVM.getPendingRequests()
            ConnectionVM.getConnectionProfiles()
        }
    }
}

struct ConnectionsView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionsView()
    }
}
