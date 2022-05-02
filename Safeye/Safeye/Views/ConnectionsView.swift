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
                Section (header: Text(translationManager.connectionCode), footer: Text(translationManager.connectiontInfo)) {
                    
                    HStack{
                        //Display connection code
                        Text("\(appState.profile?.connectionCode ?? "\(translationManager.noCode)")")
                        Spacer()

                        
                        Button(action: shareConnectionCode) { // Share conection code
                                        Image(systemName: "square.and.arrow.up.fill")
                                            .foregroundColor(.blue)
                                    }
                    }
                }
                
                // Add new contact
                HStack {
                    Text(translationManager.addNewContact)
                    Spacer()
                    Button(action: {
                        withAnimation { showingAddContact = true }
                    })
                    {
                        Image(systemName: "plus.magnifyingglass")
                            .foregroundColor(.blue)
                    }
                    .buttonStyle(BorderlessButtonStyle())

                }
                
                // Established connections
                Section(translationManager.connectionsTitle) {
                    ForEach(appState.connections) { connection in
                        let profile = ConnectionVM.filterConnectionProfileFromAppState(connection, established: true)
                        HStack{
                            Button { DispatchQueue.main.async { ConnectionVM.deleteConnection(connection.id!, "established") } } label: { Image(systemName: "trash")
                                .foregroundColor(.red) }
                            
                            Text(profile?.fullName ?? "")
                            Spacer()
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
                
                // Pending received connection requests
                Section(translationManager.receivedReqTitle) {
                    ForEach(appState.pendingConnectionRequestsTarget) { request in
                        let profile = ConnectionVM.filterConnectionProfileFromAppState(request, recieved: true)
                        HStack { Button { DispatchQueue.main.async { ConnectionVM.confirmConnectionRequest(confirmedRequest: request) }
                        } label: {Text("")}
                            
                            Text(profile?.fullName ?? "")
                            Spacer()
                            Group {
                                Text(translationManager.acceptBtn)
                                Image(systemName: "hand.thumbsup.fill")
                            }
                            .foregroundColor(.green)
                        }
                    }
                }
                
                // Pending sent connection requests
                Section(translationManager.sentReqTitle) {
                    ForEach(appState.pendingConnectionRequestsOwner) { request in
                        let profile = ConnectionVM.filterConnectionProfileFromAppState(request, sent: true)
                        HStack {

                            Text(profile?.fullName ?? "")

                            Spacer()
                            Group {
                                Text(translationManager.cancelReq)
                                Button {
                                    DispatchQueue.main.async { ConnectionVM.deleteConnection(request.id!, "sent") }
                                } label: { Image(systemName: "hand.raised.slash.fill").foregroundColor(.red) }
                            }
                            .foregroundColor(.red)
                        }
                        
                    }
                }
                
            }
            AddContactView(isShowing: $showingAddContact, searchInput: "")
            
            
        }
        .onAppear {
            print("CALLCALLCALL")
            DispatchQueue.main.async { updateAllData() }
            EventVM.sendNotification()
        }
        
        .onChange(of: appState.pendingConnectionRequestsOwner) { c in
            DispatchQueue.main.async { updateAllData() }
            print("CALLCALLCALL \(c)")
        }
        .onChange(of: appState.pendingConnectionRequestsTarget) { c in
            DispatchQueue.main.async { updateAllData() }
            print("CALLCALLCALL \(c)")
        }
        .onChange(of: appState.connections) { c in
            DispatchQueue.main.async { updateAllData() }
            print("CALLCALLCALL \(c)")
        }
    }
    
    func updateAllData() {
        DispatchQueue.main.async {
            ConnectionVM.getConnections() // established connections
            ConnectionVM.getPendingRequests() // sent and recieved
            ConnectionVM.getConnectionProfiles() // established connections
            ConnectionVM.getProfilesOfPendingConectionRequestsSentByCurrentUser() // sent
            ConnectionVM.getProfilesOfPendingConectionRequestsSentToCurrentUser() // recieved
        }
    }
    
    func shareConnectionCode() {
            guard let connectionCode = appState.profile?.connectionCode else { return }
            let activityVC = UIActivityViewController(activityItems: [connectionCode], applicationActivities: nil)
            UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
        }
    
}

struct ConnectionsView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionsView()
    }
}
