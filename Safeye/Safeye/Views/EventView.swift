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
    
    var translationManager = TranslationService.shared

    
    @State var goBack = false
    var eventID: String
    
    var body: some View {
        
        VStack {
            
            Text("\(appState.event?.status.rawValue ?? "")")
                .font(.largeTitle)
            // TODO interpolation problem with delete button
                .toolbar { Button("\(EventVM.isEventOwner() ? "Delete" : "")") {
                    EventVM.deleteEvent(eventID)
                    goBack = true
                } }
                .background(
                    NavigationLink(destination: EventListView(), isActive: $goBack) { EmptyView() }.hidden()
                )
            
            
            Form {
                Section(header: Text(translationManager.trustedContactsTrack)) {
                    ForEach(appState.eventTrustedContactsProfiles) { profile in
                        HStack {
                            //Text("\(EventVM.isEventTrustedContact() ? "You" : profile.fullName)")
                            Text("\(profile.fullName)")
                            Spacer()
                            Image(systemName: "eye.fill")
                        }
                    }
                }
                
                Section(header: Text(translationManager.eventdDetailsTrack)) {
                    Text("\(Text(translationManager.startTrack))  \(appState.event?.startTime.formatted(.dateTime) ?? "")")
                    Text("\(Text(translationManager.endTrack)) \(appState.event?.endTime.formatted(.dateTime) ?? "")")
                    Text("\(Text(translationManager.eventTypeTrack)) \(appState.event?.eventType ?? "")")
                    Text("\(Text(translationManager.otherTrack)) \(appState.event?.otherInfo ?? "")")
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
