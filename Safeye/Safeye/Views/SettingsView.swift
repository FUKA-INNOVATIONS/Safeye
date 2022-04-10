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
    @EnvironmentObject var AddContactVM: AddContactViewModel
        
    var body: some View {
        
        VStack {
            BasicButtonComponent(label: "Sign out") { // Sign out button
                ProfileVM.profileExists = false
                ProfileVM.profileDetails = nil
                AuthVM.signOut()
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
                        print(AddContactVM.pendingRequest)
                    }
                }, label: {Text("Fetch pending requests")}
                )
                
            }
            HStack {
                Text("Pending request: \(AddContactVM.pendingRequest)")
                Button(action: { AddContactVM.confirmConnectionRequest() }, label: { Text("Confirm") })
            }
            SettingsListViewComponent(settingsView: true)
        }
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
