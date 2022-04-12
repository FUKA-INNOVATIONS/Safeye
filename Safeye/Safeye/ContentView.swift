//
//  ContentView.swift
//  Safeye
//
//  Created by FUKA on 1.4.2022.
//  Edited by FUKA on 8.4.2022.

import SwiftUI


struct ContentView: View {
    @EnvironmentObject var AuthVM: AuthenticationViewModel
    @EnvironmentObject var ProfileVM: ProfileViewModel
    
    @State private var showingCreateProfile = false
    
    @State var goMapView = false
    
    
    var body: some View {
        /* DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            self.goMapView = true
         } */
        
        return Section {
            
            VStack {
                
                if !ProfileVM.profileExists {
                    // User has no profile, create new one
                    // Is displayed the first time a user joins the app
                    Text("In order to be safe, you must create a profile")
                    BasicButtonComponent(label: "Create a profile") {
                        showingCreateProfile = true
                    }
                    .sheet(isPresented: $showingCreateProfile) {
                        ProfileEditView()
                    }
                } else {
                    // User has profile -> show the app
                    NavItem()
                        .environmentObject(ProfileVM)
                        .environmentObject(AuthVM)
                    
                }
                
                
            }
            .onAppear {
                ProfileVM.getProfile()
            }
            .background(
                NavigationLink(destination: MapView(), isActive: $goMapView) {
                    EmptyView()
                }
                    .hidden()
            )
        }
        .onAppear {
            AuthVM.signedIn = AuthVM.isSignedIn
        }
        
    }
    
}


/* struct ContentView_Previews: PreviewProvider {
 static var previews: some View {
 ContentView()
 }
 } */
