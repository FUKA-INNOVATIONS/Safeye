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
    @ObservedObject var AddContactVM = AddContactViewModel()
    var PS = ProfileService()
    @State var tcList = []
    @State var contacts: [ProfileModel] = [ProfileModel]()
    @State var fetchClicked = 0
    
    
    
    
    var body: some View {
        
        return VStack {
            
            BasicButtonComponent(label: "Sign out") { // Sign out button
                ProfileVM.profileExists = false
                ProfileVM.profileDetails = nil
                AuthVM.signOut()
            }
            
            
            // TODO: don't know why this has to be fetched twice in order to show up
            if fetchClicked < 2 {
                BasicButtonComponent(label: "Fetch contacts", action: {
                    self.AddContactVM.fetchAllUsersContacts()
                    fetchClicked += 1
                })
            }
            
            
            BasicButtonComponent(label: "FetchPending") {
                //PS.fetchPendingConnectionRequests()
                AddContactVM.getPendingRequests()
            }
            
            ForEach(AddContactVM.t) {t in
                Text("\(t.connectionId)")
            }
 
            
            Text("Trusted Contacts")
            
            if AddContactVM.trustedContacts.count < 1 {
                Text("You have no contacts")
            } else {
                ForEach(AddContactVM.trustedContacts) {profile in
                    Text("\(profile.fullName)")
                    
                }
            }
            
            
            
            HStack{
                Text("Connection code: \(ProfileVM.profileDetails?.connectionCode ?? "No code")")
                Button(action: {
                    let pasteboard = UIPasteboard.general
                    pasteboard.string = ProfileVM.profileDetails?.connectionCode
                    print("Copied")
                }, label: {Text("Copy")})
                
            }.padding()
            
            
            
            
            HStack {
                Text("Pending request: \(AddContactVM.pendingRequest ?? "None")")
                Button(action: { AddContactVM.confirmConnectionRequest() }, label: {
                    Text("Confirm") })
                
            }
            
            SettingsListViewComponent(settingsView: true)
        }
        .onAppear {
            self.AddContactVM.getPendingConnectionRequests()
        }
        
        
    }
}

/* struct SettingsView_Previews: PreviewProvider {
 static var previews: some View {
 SettingsView()
 }
 } */
