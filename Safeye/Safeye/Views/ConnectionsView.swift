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
    @EnvironmentObject var appState: Store
    var translationManager = TranslationService.shared
    @State var showingConnectionProfile = false
    
    var body: some View {
        
        VStack {
            Spacer(minLength: 50)
            
            Form {
                Section (header: Text("Connection code"), footer: Text("Your connection code is the only way people can find you on Safeye. Share it with others and they'll be able to send you a connection request.")) {
                    
                    HStack{
                        Text("\(appState.profile?.connectionCode ?? "No code")")
                        Spacer()
                        
                        Button(action: {
                            let pasteboard = UIPasteboard.general
                            pasteboard.string = appState.profile?.connectionCode
                            print("Copied")
                            //                }, label: {Text("Copy")})
                        }, label: {Text(translationManager.copyBtn)})
                        
                    }
                }
                
                //                Section("Connections") {
                Section(translationManager.connectionsTitle) {
                    ForEach(appState.connections) { connection in
                        //_ = ConnectionVM.filterConnectionProfileFromAppState(connection)
                        HStack{
                            //Image(systemName: "trash")
                            Button { ConnectionVM.deleteConnection(connection.id!, "established") } label: { Image(systemName: "trash")
                                .foregroundColor(.red) }
                            
                            Text("Full name")
                            Spacer()
                            //                            Text("profile")
                            Text(translationManager.profileBtn)
                            Button { showingConnectionProfile = true } label: { Image(systemName: "eye") }
                            
                            
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        
                        .sheet(isPresented: $showingConnectionProfile) {
                            //ProfileView(profileID: connection.id!)
                        }
                    }
                    
                }
                
                //                Section("Received requests") {
                Section(translationManager.receivedReqTitle) {
                    ForEach(appState.pendingConnectionRequestsTarget) { request in
                        HStack { Button { ConnectionVM.confirmConnectionRequest(confirmedRequest: request)} label: {Text("")}
                            
                            Text("Full name")
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
                
                //                Section("Sent requests") {
                Section(translationManager.sentReqTitle) {
                    ForEach(appState.pendingConnectionRequestsOwner) { request in
                        HStack {
                            Text("Full name")
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
            
        }
        //.padding(.top, -100)
        //.ignoresSafeArea()
        .onAppear {
            ConnectionVM.getConnections()
            ConnectionVM.getPendingRequests()
            ConnectionVM.getConnectionProfiles()
            EventVM.sendNotification()
        }
    }
}

struct ConnectionsView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionsView()
    }
}
