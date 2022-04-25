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
    @EnvironmentObject var appState: Store
    @StateObject private var notificationService = NotificationService.shared
    @EnvironmentObject var EventVM: EventViewModel
    @EnvironmentObject var ConnectionVM: ConnectionViewModel
    var translationManager = TranslationService.shared
    
    @State private var showingCreateProfile = false
    @State var goMapView = false
    
    
    var body: some View {
        
        return Section {
            
            VStack {
                //TODO: BUG : after registration, create profile is not displayed, it is diaplyed on next app start
                if appState.profile == nil {
                    // User has no profile, create new one
                    // Is displayed the first time a user joins the app
                    //                    Text("In order to be safe, you must create a profile")
                    //                    BasicButtonComponent(label: "Create a profile") {
                    Text(translationManager.textProfile)
                    BasicButtonComponent(label: translationManager.createProfileBtn) {
                        showingCreateProfile = true
                    }
                    .sheet(isPresented: $showingCreateProfile) {
                        ProfileEditView()
                    }
                } else {
                    // User has profile -> show the app
                    VStack {
                        // Show alert on every view when someone in panic mode
                        if !appState.eventsPanic.isEmpty { AlertPanicComponent() }
                        NavItem()
                    }
                    
                }
                
                
            }
            .onAppear {
                ProfileVM.getProfileForCurrentUser()
            }
            .onAppear(perform: notificationService.reloadAuthorizationStatus)
            .onChange(of: notificationService.authorizationStatus) { authorizationStatus in
                if notificationService.authorizationStatus == .authorized {
                    notificationService.reloadLocalNotifications()
                }
                if notificationService.authorizationStatus == .notDetermined {
                    notificationService.requestAuthorization()
                }
            }
            .background(
                NavigationLink(destination: MapView(), isActive: $goMapView) {
                    EmptyView()
                }
                    .hidden()
            )
        }
        .onAppear {
            print("content view appeared")
            AuthVM.signedIn = AuthVM.isSignedIn
            
//            ConnectionVM.getConnections()
//            ConnectionVM.getConnectionProfiles()
//            ConnectionVM.getPendingRequests()
//            EventVM.getEventsOfCurrentUser()
//            EventVM.getEventsOfTrustedContacts()
        }
    }
}
