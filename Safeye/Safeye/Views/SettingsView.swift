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
    @EnvironmentObject var Add_ContactVM: AddContactViewModel
    var PS = ProfileService.instance
    @State var tcList = []
    @State var contacts: [ProfileModel] = [ProfileModel]()
    @State var fetchClicked = 0
    
    //@ObservedObject var ConnVM = ConnectionViewModel


        
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
                    self.Add_ContactVM.fetchAllUsersContacts()
                    fetchClicked += 1
                })
            }
            
            NavigationLink("Playground") {
                PlayGroundView()
            }
            
            NavigationLink("Create event") {
                CreateEventView()
            }
            
            
            Text("Trusted Contacts")
            
            if Add_ContactVM.trustedContacts.count < 1 {
                Text("You have no contacts")
            } else {
                ForEach(Add_ContactVM.trustedContacts) {profile in
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
                Text("Pending request: \(Add_ContactVM.pendingRequest ?? "None")")
                Button(action: { Add_ContactVM.confirmConnectionRequest() }, label: {
                    Text("Confirm") })
                
            }
            
            SettingsListViewComponent(settingsView: true)
        }
        .onAppear {
            self.Add_ContactVM.getPendingConnectionRequests()
        }
        
        
    }
}

/* struct SettingsView_Previews: PreviewProvider {
 static var previews: some View {
 SettingsView()
 }
 } */
