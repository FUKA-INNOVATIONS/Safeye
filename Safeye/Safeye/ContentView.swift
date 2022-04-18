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
    @EnvironmentObject var ConnectionVM: ConnectionViewModel
    @EnvironmentObject var EventVM: EventViewModel
    @EnvironmentObject var MapVM: MapViewModel
    @EnvironmentObject var appState: Store
    @EnvironmentObject var FileVM: FileViewModel
    
    @StateObject private var notificationService = NotificationService()
    
    @State private var showingCreateProfile = false
    
    @State var goMapView = false
    
    
    var body: some View {

        return Section {
            
            VStack {
                //TODO: BUG : after registration, create profile is not displayed, it is diaplyed on next app start
                if appState.profile == nil {
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
//            .onChange(of: notificationManager.authorizationStatus) { authorizationStatus in
//                switch authorizationStatus {
//                case .notDetermined:
//                    // request authorization
//                    notificationManager.requestAuthorization()
//                case .authorized:
//                    // get local notification
//                    notificationManager.reloadLocalNotifications()
//                default:
//                    break
//                }
//            }
            .background(
                NavigationLink(destination: MapView(), isActive: $goMapView) {
                    EmptyView()
                }
                    .hidden()
            )
        }
        .onAppear {
            AuthVM.signedIn = AuthVM.isSignedIn
            ConnectionVM.getConnections()
            ConnectionVM.getConnectionProfiles()
        }
        
    }
    
}


/* struct ContentView_Previews: PreviewProvider {
 static var previews: some View {
 ContentView()
 }
 } */
