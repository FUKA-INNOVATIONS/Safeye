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
    @EnvironmentObject var EventVM: EventViewModel
    @EnvironmentObject var FileVM: FileViewModel
    @EnvironmentObject var appState: Store
    var translationManager = TranslationService.shared
    @State var showingConnectionProfile = false
    @State private var showingAddContact = false
    
    
    var body: some View {
        
        ZStack {
            Spacer(minLength: 50)
            
            //Connection code
            Form {
                Section (header: Text("Connection code"), footer: Text("Your connection code is the only way people can find you on Safeye. Share it with others and they'll be able to send you a connection request.")) {
                    
                    HStack{
                        //Display connection code
                        Text("\(appState.profile?.connectionCode ?? "No code")")
                        Spacer()
                        
                        //Copy code to clipboard
                        Button(action: {
                            let pasteboard = UIPasteboard.general
                            pasteboard.string = appState.profile?.connectionCode
                        }, label: {Text(translationManager.copyBtn)})
                            .foregroundColor(.blue)
                    }
                }
                
                // Add new contact
                HStack {
                    Text("Add a new contact")
                    Spacer()
                    Button(action: {
                        showingAddContact = true
                    })
                    {
                        Image(systemName: "plus.magnifyingglass")
                            .foregroundColor(.blue)
                    }
                }
                
                // Section("Connections") {
                Section(translationManager.connectionsTitle) {
                    ForEach(appState.connections) { connection in
                        let profile = ConnectionVM.filterConnectionProfileFromAppState(connection)
                        HStack{
                            //Image(systemName: "trash")
                            Button { ConnectionVM.deleteConnection(connection.id!, "established") } label: { Image(systemName: "trash")
                                .foregroundColor(.red) }
                            
                            Text(profile?.fullName ?? "")
                            Spacer()
                            //                            Text("profile")
                            Text(translationManager.profileBtn)
                            Button {
                                // fetch trusted contact photo
                                FileVM.fetchPhoto(avatarUrlFetched: profile!.avatar, isSearchResultPhoto: false, isTrustedContactPhoto: true)
                                
                                //set trusted contact profile in app state to profile
                                self.appState.tCProfile = profile
                                
                                //opens trusted contact profile view
                                showingConnectionProfile = true
                            } label: { Image(systemName: "eye") }
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        
                        .sheet(isPresented: $showingConnectionProfile) {
                            TCProfileView()
                        }
                    }
                    
                }
                
                // Section("Received requests") {
                Section(translationManager.receivedReqTitle) {
                    ForEach(appState.pendingConnectionRequestsTarget) { request in
                        let profile = ConnectionVM.filterPendingReqProfileFromAppState(request)
                        HStack { Button { ConnectionVM.confirmConnectionRequest(confirmedRequest: request)} label: {Text("")}
                            
                            Text(profile?.fullName ?? "")
                            Spacer()
                            Group {
                                //                                Text("accept")
                                Text(translationManager.acceptBtn)
                                Image(systemName: "hand.thumbsup.fill")
                            }
                            .foregroundColor(.green)
                        }
                    }
                }
                
                // Section("Sent requests") {
                Section(translationManager.sentReqTitle) {
                    ForEach(appState.pendingConnectionRequestsOwner) { request in
                        let profile = ConnectionVM.filterSentReqProfileFromAppState(request)
                        HStack {
                            Text(profile?.fullName ?? "")
                            Spacer()
                            Group {
                                //                                Text("cancel")
                                Text(translationManager.cancelReq)
                                Button { ConnectionVM.deleteConnection(request.id!, "sent") } label: { Image(systemName: "hand.raised.slash.fill").foregroundColor(.red) }
                            }
                            .foregroundColor(.red)
                        }
                    }
                }
                
            }
            AddContactView(isShowing: $showingAddContact, searchInput: "")
            
            
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .onAppear {
            ConnectionVM.getConnections()
            ConnectionVM.getPendingRequests()
            ConnectionVM.getConnectionProfiles()
            ConnectionVM.getPendingReqProfiles()
            ConnectionVM.getSentReqProfiles()
            EventVM.sendNotification()
        }
        
    }
}

struct ConnectionsView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionsView()
    }
}
