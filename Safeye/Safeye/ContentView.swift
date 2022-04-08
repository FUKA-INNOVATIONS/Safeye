//
//  ContentView.swift
//  Safeye
//
//  Created by FUKA on 1.4.2022.
//  Edited by FUKA on 8.4.2022.

import SwiftUI


struct ContentView: View {
    @EnvironmentObject var AuthenticationViewModel: AuthenticationViewModel
    @StateObject var profileViewModel = ProfileViewModel()
    @State private var showingCreateProfile = false
    

    var body: some View {
        /*DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
         profileViewModel.getProfile()
         }*/
        
        return Section {
            VStack {
                if AuthenticationViewModel.isSignedIn {
                    // User is signed in
                    
                    if profileViewModel.profileExists {
                        Section {
                            Text(profileViewModel.profileDetails?.fullName ?? "No name")
                        }
                        
                        HStack {
                            NavigationLink("Go to MapView", destination: MapView())
                                .padding()
                            
                            NavigationLink("Go to ProfileView", destination: NavigationLazyView(ProfileView()))
                                .padding()
                        }
                        BasicButtonComponent(label: "Sign out") { // Sign out button
                            profileViewModel.profileExists = false
                            profileViewModel.profileDetails = nil
                            AuthenticationViewModel.signOut()
                        }
                    } else {
                        Text("In order to be safe, you must create a profile")
                        BasicButtonComponent(label: "Create a profile") {
                            showingCreateProfile = true
                        }
                        .sheet(isPresented: $showingCreateProfile) {
                            ProfileEditView(profileViewModel: profileViewModel)
                        }
                        
                    }
                    
                    
                } else {
                    // User has not signed in
                    LoginView() // Show Login
                }
                
            }
            .onAppear {
                profileViewModel.getProfile()
            }
        }
        .onAppear {
            AuthenticationViewModel.signedIn = AuthenticationViewModel.isSignedIn
        }
    }
    
}


/* struct ContentView_Previews: PreviewProvider {
 static var previews: some View {
 ContentView()
 }
 } */
