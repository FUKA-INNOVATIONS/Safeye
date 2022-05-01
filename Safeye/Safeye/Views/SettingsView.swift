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
//            Section(header: Text("Settings"), footer: Text("Once 'Update home coordinates' is clicked, your coordinates will be automatically updated to match your current location.")) {
            Section(header: Text(translationManager.settingsTitle), footer: Text(translationManager.updateCoordinatesInfo)) {
                VStack{
                    Picker("Mode", selection: $isDarkMode){
//                    Text("Light")
                        Text(translationManager.lightMode)
                        .tag(false)
//                    Text("Dark")
                        Text(translationManager.darkMode)
                        .tag(true)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                }
                
                // Update user's home coordinates
                // TODO: add popup info box when pressed
                if CLLocationManager().authorizationStatus.rawValue == 4 {
//                    Button("Update Home Coordinates") {
                    Button(translationManager.updateCoordinatesBtn) {
                        ProfileVM.updateUserHomeCoordinates()
                    }
                }
                
            }
            
            
//            Section("Information") {
            Section(translationManager.settingsTitle) {
                List{
//                    Text("About Safeye")
                    Text(translationManager.aboutSafeye)
                        .onTapGesture {
                            section = "about"
                            isInfoDetailShowing = true
                        }
                    
//                    Text("How it works")
                    Text(TranslationService.shared.howItWorksTitle)
                        .onTapGesture {
                            section = "how"
                            isInfoDetailShowing = true
                        }
                    
//                    Text("FAQ")
                    Text(translationManager.faqTitle)
                        .onTapGesture {
                            section = "FAQ"
                            isInfoDetailShowing = true
                        }
                    
//                    Text("Privacy")
                    Text(translationManager.privacyTitle)
                        .onTapGesture {
                            section = "privacy"
                            isInfoDetailShowing = true
                        }
                }
                .sheet(isPresented: $isInfoDetailShowing) {
                    InfoDetailView(section: $section)
                }
            }
            
            HStack {
                // Sign out button
                Button(translationManager.signOut) {
                    AuthVM.signOut()
                }
                .foregroundColor(.red)
                Spacer()
                Text("\(AuthenticationService.getInstance.currentUser?.email ?? "")").foregroundColor(.gray).font(.caption2)
            }
            
        }
//        .navigationTitle("")
//        .navigationBarHidden(true)
        .onAppear {
            //EventVM.getEventsOfTrustedContacts() // to check for panic events
            //EventVM.getEventsOfCurrentUser()
            EventVM.sendNotification()
        }
    }
}
