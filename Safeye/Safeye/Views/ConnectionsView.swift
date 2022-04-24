//
//  ConnectionsView.swift
//  Safeye
//
//  Created by FUKA on 18.4.2022.
//

import SwiftUI

struct ConnectionsView: View {
    @EnvironmentObject var ConnectionVM: ConnectionViewModel
    @EnvironmentObject var EventVM: EventViewModel
    @EnvironmentObject var FileVM: FileViewModel
    @EnvironmentObject var appState: Store
    @State var showingConnectionProfile = false
    
    var body: some View {
        
        return VStack {
            Form {
                
                Section("Connections") {
                    ForEach(appState.connections) { connection in
                        let profile = ConnectionVM.filterConnectionProfileFromAppState(connection)
                        Button { ConnectionVM.deleteConnection(connection.id!, "established") } label: { Image(systemName: "trash").foregroundColor(.red) }
                        HStack {
                            Image(systemName: "trash")
                            Text(profile.fullName)
                            Spacer()
                            Text("profile")
                            Button {
                                showingConnectionProfile = true
                                FileVM.fetchPhoto(avatarUrlFetched: profile.avatar, isSearchResultPhoto: false, isTrustedContactPhoto: true)
                            } label: { Image(systemName: "eye") }
                        }
                        .sheet(isPresented: $showingConnectionProfile) {
                            TCProfileView(profile: profile)
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
                                Button { ConnectionVM.deleteConnection(request.id!, "sent") } label: { Image(systemName: "hand.raised.slash.fill").foregroundColor(.red) }
                            }
                            .foregroundColor(.red)
                        }
                    }
                }
                
            }
            
        }
        .onAppear {
            //ConnectionVM.getConnections()
            ConnectionVM.getPendingRequests()
            //ConnectionVM.getConnectionProfiles()
            EventVM.sendNotification()
        }
    }
}

struct ConnectionsView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionsView()
    }
}
