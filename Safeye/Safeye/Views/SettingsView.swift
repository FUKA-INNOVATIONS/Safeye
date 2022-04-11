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

    
    var body: some View {
        
        return VStack {
            
            ForEach(AddContactVM.trustedContacts) {profile in
                Text("\(profile.fullName)")
                
            }
            
            BasicButtonComponent(label: "Sign out") { // Sign out button
                ProfileVM.profileExists = false
                ProfileVM.profileDetails = nil
                AuthVM.signOut()
            }
            .onAppear {
                self.AddContactVM.fetchAllUsersContacts()
            }
            HStack{
                Text("Connection code: \(ProfileVM.profileDetails?.connectionCode ?? "No code")")
                Button(action: {
                    let pasteboard = UIPasteboard.general
                    pasteboard.string = ProfileVM.profileDetails?.connectionCode
                    print("Copied")
                }, label: {Text("Copy")})
                
            }.padding()
            
            VStack {
                
                Button(action: {
                    AddContactVM.getPendingConnectionRequests()
                    if AddContactVM.connectionsPending {
                        let reqList = AddContactVM.pendingArray
                        print(reqList)
                    }
                }, label: {Text("Fetch pending requests")}
                )
            }
            
            HStack {
                Text("Pending request: \(AddContactVM.pendingRequest ?? "None")")
                Button(action: { AddContactVM.confirmConnectionRequest() }, label: { Text("Confirm") })
                
            }
            
            SettingsListViewComponent(settingsView: true)
        }
        
        
    }
}

/* struct SettingsView_Previews: PreviewProvider {
 static var previews: some View {
 SettingsView()
 }
 } */
