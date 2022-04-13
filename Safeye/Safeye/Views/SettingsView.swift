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
            
            BasicButtonComponent(label: "ADD conn") {
                AddContactVM.addConnection("asdas3434343dasd")
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
