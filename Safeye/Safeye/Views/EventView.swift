//
//  TrackingModeView.swift
//  Safeye
//
//  Created by dfallow on 10.4.2022.
//

import SwiftUI

struct EventView: View {
    @EnvironmentObject var EventVM: EventViewModel
    @EnvironmentObject var appState: Store
    @State var eventID: String
    
    @State var panicMode: Bool = false // replace with appState
    
    var body: some View {
        
        VStack {
            
            Text("Current Status: \(appState.event?.status.rawValue ?? "")")
                .font(.largeTitle)
            Spacer()
            
            Form {
                Section(header: Text("Trusted contacts")) {
                    ForEach(appState.eventTrustedContactsProfiles) { profile in
                        HStack {
                            Text("\(profile.fullName)")
                            Spacer()
                            Image(systemName: "eye.fill")
                        }
                    }
                }
                
                Section(header: Text("Event details")) {
                    Text("EventType: \(appState.event?.eventType ?? "")")
                    Text("Other info: \(appState.event?.otherInfo ?? "")")
                }
                
            }
            
            if EventVM.isOwner(of: appState.event?.ownerId ?? "") {
                appState.event!.status == .STARTED ?
                Button(action: {
                    // Actions after panic button Has been pressed
                    
                    EventVM.activatePanicMode()
                    //panicMode = true
                    EventVM.sentNotification()
                }) {
                    TrackingModeButtonComponent(panicmode: $panicMode)
                }
                :
                // User is in panic mode presses are you safe button
                Button(action: {
                    
                    EventVM.disablePanicMode()
                    //panicMode = false
                    
                }) {
                    TrackingModeButtonComponent(panicmode: $panicMode)
                }
            }
            
            
            
            Spacer()
            /*EventVM.mode == "Tracking" ?
            // User is currently in tracking mode, presses panic button for help
            Button(action: {
                // Actions after panic button Has been pressed
                
                EventVM.activatePanicMode()
                panicMode = true
                EventVM.sentNotification()
            }) {
                TrackingModeButtonComponent(panicmode: $panicMode)
            }
            :
            // User is in panic mode presses are you safe button
            Button(action: {
                
                EventVM.disablePanicMode()
                panicMode = false
                
            }) {
                TrackingModeButtonComponent(panicmode: $panicMode)
            }*/
            //PanicButtonComponent()
            Spacer()
            
            //Send value of tracking: true to map view
            /* NavigationLink("View Map", destination: MapView())
                .padding() */
            
            // Replace with button?
            /*NavigationLink("Disable Tracking", destination: ContentView())
                .disabled(true)*/
            
            Spacer()
            
        }
        //.navigationBarHidden(true)
        .onAppear {
            EventVM.getDetails(for: eventID)
            EventVM.getEventTrustedContactsProfiles(eventID: eventID)
        }
        
    }
    
}

/*struct TrackingModeView_Previews: PreviewProvider {
    static var previews: some View {
        EventView()
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}*/
