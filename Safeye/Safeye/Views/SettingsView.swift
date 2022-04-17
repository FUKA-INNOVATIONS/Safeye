//
//  SettingsView.swift
//  Safeye
//
//  Created by FUKA on 1.4.2022.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var ProfileVM: ProfileViewModel
    @EnvironmentObject var AuthVM: AuthenticationViewModel
    @EnvironmentObject var EventVM: EventViewModel
    @State var tcList = []
    @State var contacts: [ProfileModel] = [ProfileModel]()
    @State var fetchClicked = 0
    
    @EnvironmentObject var appState: Store


        
    var body: some View {
        
        return VStack {
            
            BasicButtonComponent(label: "Sign out") { // Sign out button
                AuthVM.signOut()
            }
            
            NavigationLink("Playground") {
                PlayGroundView()
            }
            
            /* NavigationLink("\(appState.eventCurrentUser == nil ? "Create event" : "You have an event")") {
                if appState.eventCurrentUser == nil {
                    CreateEventView()
                } else {
                    EventView()
                }
            } */
            
            
            HStack{
                Text("Connection code: \(appState.profile?.connectionCode ?? "No code")")
                Button(action: {
                    let pasteboard = UIPasteboard.general
                    pasteboard.string = appState.profile?.connectionCode
                    print("Copied")
                }, label: {Text("Copy")})
                
            }.padding()
            
            
            SettingsListViewComponent(settingsView: true)
        }
        .onAppear {
            EventVM.getEventsOfCurrentUser()
        }
        
        
    }
}

/* struct SettingsView_Previews: PreviewProvider {
 static var previews: some View {
 SettingsView()
 }
 } */
