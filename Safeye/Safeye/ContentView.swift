//
//  ContentView.swift
//  Safeye
//
//  Created by FUKA on 1.4.2022.
//  Edited by FUKA on 8.4.2022.

import SwiftUI


struct ContentView: View {
    
    @State var inputText: String = "Hello input"
    @State var passsword: String = ""
    @EnvironmentObject var AuthenticationViewModel: AuthenticationViewModel
    @ObservedObject var profileViewModel = ProfileViewModel()
    @State var createProfileMode = false
    
    init() {
        profileViewModel.getProfile()
    }
    
    var body: some View {
        Section {
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
                            AuthenticationViewModel.signOut()
                        }
                    } else {
                        Text("In order to be safe, you must create a profile")
                        BasicButtonComponent(label: "Create a profile") {
                            createProfileMode.toggle()
                        }
                        .sheet(isPresented: $createProfileMode) {
                            ProfileEditView()
                        }
                        
                    }
                    
                    
                } else {
                    // User has not signed in
                    LoginView() // Show Login
                }
                
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
