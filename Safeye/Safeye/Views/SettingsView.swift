//
//  SettingsView.swift
//  Safeye
//
//  Created by FUKA on 1.4.2022.
//

import SwiftUI
import CoreLocation

struct SettingsView: View {
    @EnvironmentObject var ProfileVM: ProfileViewModel
    @EnvironmentObject var AuthVM: AuthenticationViewModel
    @EnvironmentObject var EventVM: EventViewModel
    @EnvironmentObject var MapVM: MapViewModel
    @EnvironmentObject var appState: Store
    var translationManager = TranslationService.shared
    @State var tcList = []
    @State var contacts: [ProfileModel] = [ProfileModel]()
    @State var fetchClicked = 0
    @State var isInfoDetailShowing = false
    @State var section: String?

    @AppStorage("isDarkMode") private var isDarkMode = false

        
    var body: some View {
        
        Form {
            Section(header: Text("Settings"), footer: Text("Once 'Update home coordinates' is clicked, your coordinates will be automatically updated to match your current location.")) {
                VStack{
                    Picker("Mode", selection: $isDarkMode){
                    Text("Light")
                        .tag(false)
                    Text("Dark")
                        .tag(true)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                }
                
                // Update user's home coordinates
                // TODO: add popup info box when pressed
                if CLLocationManager().authorizationStatus.rawValue == 4 {
                    Button("Update Home Coordinates") {
                        ProfileVM.updateUserHomeCoordinates()
                    }
                }
                
            }
            
            
            Section("Information") {
                List{
                    Text("About Safeye")
                        .onTapGesture {
                            section = "about"
                            isInfoDetailShowing = true
                        }
                    
                    Text("How it works")
                        .onTapGesture {
                            section = "how"
                            isInfoDetailShowing = true
                        }
                    
                    Text("FAQ")
                        .onTapGesture {
                            section = "FAQ"
                            isInfoDetailShowing = true
                        }
                    
                    Text("Privacy")
                        .onTapGesture {
                            section = "privacy"
                            isInfoDetailShowing = true
                        }
                }
                .sheet(isPresented: $isInfoDetailShowing) {
                    InfoDetailView(section: $section)
                }
            }
            
            // Sign out button
            Button(translationManager.signOut) {
                AuthVM.signOut()
            }
            .foregroundColor(.red)
            
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .onAppear {
            //EventVM.getEventsOfTrustedContacts() // to check for panic events
            //EventVM.getEventsOfCurrentUser()
            EventVM.sendNotification()
        }
    }
}
