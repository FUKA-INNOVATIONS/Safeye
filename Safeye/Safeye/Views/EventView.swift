//
//  TrackingModeView.swift
//  Safeye
//
//  Created by dfallow on 10.4.2022.
//  Edited by FUKA

import SwiftUI

struct EventView: View {
    @EnvironmentObject var EventVM: EventViewModel
    @EnvironmentObject var appState: Store
    
    //@State var goBack = false
    var eventID: String
    
    var body: some View {
        
        VStack {
            
            Text("\(appState.event?.status.rawValue ?? "")")
                .font(.largeTitle)
                /*.toolbar { Button("\(EventVM.isEventOwner() ? "Delete" : "")") {
                    EventVM.deleteEvent(eventID)
                    goBack = true
                } }
                .background(
                    NavigationLink(destination: EventListView(), isActive: $goBack) { EmptyView() }.hidden()
                )*/
            
            
            Form {
                Section(header: Text("Trusted contacts")) {
                    ForEach(appState.eventTrustedContactsProfiles) { profile in
                        HStack {
                            //Text("\(EventVM.isEventTrustedContact() ? "You" : profile.fullName)")
                            Text("\(profile.fullName)")
                            Spacer()
                            Image(systemName: "eye.fill")
                        }
                    }
                }
                
                Section(header: Text("Event details")) {
                    Text("Starting from  \(appState.event?.startTime.formatted(.dateTime) ?? "")")
                    Text("Ending at  \(appState.event?.endTime.formatted(.dateTime) ?? "")")
                    Text("Envent type: \(appState.event?.eventType ?? "")")
                    Text("Other info: \(appState.event?.otherInfo ?? "")")
                }
                
            }
            
            if EventVM.isEventOwner() {
                appState.event!.status == .STARTED ?
                Button(action: { // Actions after panic button Has been pressed
                    EventVM.activatePanicMode()
                    //EventVM.sentNotification()
                }) {
                    TrackingModeButtonComponent()
                }
                : // User is in panic mode presses safe button
                Button(action: {
                    EventVM.disablePanicMode()
                }) {
                    TrackingModeButtonComponent()
                }
            }
            
            
            
            Spacer()
            
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
            EventVM.getEventTrustedContactsProfiles(eventID: eventID)
            EventVM.getDetails(for: eventID)
            //EventVM.checkIfLocationServicesIsEnabled() // This creates ui isssue, user is sent back to eventListView
            // let eventListener = EventVM.getDetails(for: eventID)
        }
        
    }
    
}

/*struct TrackingModeView_Previews: PreviewProvider {
 static var previews: some View {
 EventView()
 .previewInterfaceOrientation(.portraitUpsideDown)
 }
 }*/
