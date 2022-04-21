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
    @State var showingConnectionProfile = false
    
    var translationManager = TranslationService.shared

    var body: some View {
        VStack {
            
            Form {
                
                Section(translationManager.connectionsTitle) {
                    ForEach(appState.connections) { connection in
                        //_ = ConnectionVM.filterConnectionProfileFromAppState(connection)
                        Button { ConnectionVM.deleteConnection(connection.id!) } label: { Image(systemName: "trash").foregroundColor(.red) }
                        HStack {
                            Image(systemName: "trash")
                            Text("Full name")
                            Spacer()
                            Text(translationManager.profileBtn)
                            Button { showingConnectionProfile = true } label: { Image(systemName: "eye") }
                        }
                        .sheet(isPresented: $showingConnectionProfile) {
                            //ProfileView(profileID: connection.id!)
                        }
                        //.background( NavigationLink(destination: ProfileView(profileID: connection.id!), isActive: $goConnectionProfile) { EmptyView() }.hidden() )
                    }
                    
                }
                
                Section(translationManager.receivedReqTitle) {
                    ForEach(appState.pendingConnectionRequestsTarget) { request in
                        HStack { Button { ConnectionVM.confirmConnectionRequest(confirmedRequest: request)} label: {Text("")}
                            
                            Text("Full name")
                            Spacer()
                            Group {
                                Text(translationManager.acceptBtn)
                                Image(systemName: "hand.thumbsup.fill")
                            }
                            .foregroundColor(.green)
                        }
                    }
                }
                
                Section(translationManager.sentReqTitle) {
                    ForEach(appState.pendingConnectionRequestsOwner) { request in
                        HStack {
                            Text("Full name")
                            Spacer()
                            Group {
                                Text(translationManager.cancelReq)
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
