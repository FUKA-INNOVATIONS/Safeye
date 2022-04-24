//
//  TrackingModeView.swift
//  Safeye
//
//  Created by dfallow on 10.4.2022.
//  Edited by FUKA

import SwiftUI
import nanopb

struct EventView: View {
    @EnvironmentObject var EventVM: EventViewModel
    @EnvironmentObject var appState: Store
    
    @StateObject var voiceRecognizer = VoiceRecognizer()

    @State var panicMode: Bool = false
    @State private var isPresented: Bool = false
    @State private var text: String = ""
    @State private var showingRecordMessage: Bool = false
    
    //@State var goBack = false
    var eventID: String
    
    var body: some View {
        
        return VStack {
            
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
                    Text("Envent type: \(appState.event?.city ?? "")")
                    Text("Starting from  \(appState.event?.startTime.formatted(.dateTime) ?? "")")
                    Text("Ending at  \(appState.event?.endTime.formatted(.dateTime) ?? "")")
                    Text("Envent type: \(appState.event?.eventType ?? "")")
                    Text("Other info: \(appState.event?.otherInfo ?? "")")
                }
                
            }
            
            if EventVM.isEventOwner() {
                Button { showingRecordMessage = true } label: { Text("Record Message"); Image(systemName: "mic.circle") }
                .disabled( appState.panicMode == true)
                .opacity( appState.panicMode == true ? 0 : 1)
                .padding()
                .sheet(isPresented: $showingRecordMessage) {
                    RecordingView()
                }
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
          
            alertBoxComponent(buttonIsPressed: $isPresented,text: $text, panicMode: $panicMode)
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
