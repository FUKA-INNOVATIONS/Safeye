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
    @EnvironmentObject var LocationVM: LocationViewModel
    var translationManager = TranslationService.shared
    
    @State private var showingCreateProfile = false
    @State var goMapView = false
    
    
    var body: some View {
        
        return VStack {
            
            VStack {
                //TODO: BUG : after registration, create profile is not displayed, it is diaplyed on next app start
//                if self.appState.appLoading { AnimationLottieView(lottieJson: "eye") }
                if appState.profile == nil {
                    // User has no profile, create new one
                    
//                    Text("Sinä päätät ketkä näkevät profiilisi")
                    Text(translationManager.youDecidetext)
                    AnimationLottieView(lottieJson: "profiles-of-people")
                    
                    Spacer()
                    Text(translationManager.textProfile)
                        .font(.headline)
                    
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
//                    .navigationTitle("Safeye")
//                    .navigationBarTitleDisplayMode(.automatic)
                    
                }
                
                
            }
            .onAppear {
                ProfileVM.getProfileForCurrentUser()
                LocationVM.checkIfLocationServicesIsEnabled()
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
//        .navigationTitle("")
//        .navigationBarHidden(true)
        .onAppear {
            print("content view appeared")
            AuthVM.signedIn = AuthVM.isSignedIn
        }
    }
}
