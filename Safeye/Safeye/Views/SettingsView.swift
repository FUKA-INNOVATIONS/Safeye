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
    @State var tcList = []
    @State var contacts: [ProfileModel] = [ProfileModel]()
    @State var fetchClicked = 0
    
    @EnvironmentObject var appState: Store


        
    var body: some View {
        
        return VStack {
            
            BasicButtonComponent(label: "Sign out") { // Sign out button
                AuthVM.signOut()
            }
            
            // TODO: don't know why this has to be fetched twice in order to show up
            if fetchClicked < 2 {
                BasicButtonComponent(label: "Fetch contacts", action: {
                    fetchClicked += 1
                })
            }
            
            NavigationLink("Playground") {
                PlayGroundView()
            }
            
            NavigationLink("Create event") {
                CreateEventView()
            }
            
            
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
            
        }
        
        
    }
}

/* struct SettingsView_Previews: PreviewProvider {
 static var previews: some View {
 SettingsView()
 }
 } */
