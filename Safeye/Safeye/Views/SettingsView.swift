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
    @State var tcList = []
    @State var contacts: [ProfileModel] = [ProfileModel]()
    @State var fetchClicked = 0
    
    @EnvironmentObject var appState: Store


        
    var body: some View {
        
        return VStack {
            
            BasicButtonComponent(label: "Sign out") { // Sign out button
                AuthVM.signOut()
            }
            
            NavigationLink("Playground") {
                PlayGroundView()
            }
            
            NavigationLink("Go To Map") {
                MapView()
            }
            
            /* NavigationLink("\(appState.eventCurrentUser == nil ? "Create event" : "You have an event")") {
                if appState.eventCurrentUser == nil {
                    CreateEventView()
                } else {
                    EventView()
                }
            } */
            
            // Button to update users home coordinates
            // TODO add popup info box when pressed
            if CLLocationManager().authorizationStatus.rawValue == 4 {
                Button("Update Home Coordinates") {
                    ProfileVM.updateUserHomeCoordinates()
                }
            }
            HStack{
                Text("Connection code: \(appState.profile?.connectionCode ?? "No code")")
                Button(action: {
                    let pasteboard = UIPasteboard.general
                    pasteboard.string = appState.profile?.connectionCode
                    print("Copied")
                }, label: {Text("Copy")})
                
            }.padding()
            
            SettingsListViewComponent(settingsView: true)
        }
        .onAppear {
            //EventVM.getEventsOfTrustedContacts() // to check for panic events
            //EventVM.getEventsOfCurrentUser()
            EventVM.sendNotification()
        }
        
        
    }
}

/* struct SettingsView_Previews: PreviewProvider {
 static var previews: some View {
 SettingsView()
 }
 } */
