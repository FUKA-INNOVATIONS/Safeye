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
    var translationManager = TranslationService.shared
    
    @StateObject var locationManager = LocationViewModel()
    @StateObject var voiceRecognizer = VoiceRecognizer()

    @State var panicMode: Bool = false
    @State private var isPresented: Bool = false
    @State private var text: String = ""
    @State private var showingRecordMessage: Bool = false
    @State private var showingRecordedMessageView: Bool = false
    
    
    //@State var goBack = false
    var eventID: String
    
    var body: some View {
        
        return VStack {
            
            VStack {
                Text("\(appState.event?.status.rawValue ?? "")")
                    .font(.largeTitle).foregroundColor(appState.event?.status == .STARTED ? .green : .red)
                    /*.toolbar { Button("\(EventVM.isEventOwner() ? "Delete" : "")") {
                        EventVM.deleteEvent(eventID)
                        goBack = true
                    } }
                    .background(
                        NavigationLink(destination: EventListView(), isActive: $goBack) { EmptyView() }.hidden()
                    )*/
                
                
                Form {
                    Section(header: Text(translationManager.trustedContactsTrack)) {
                        ForEach(appState.eventTrustedContactsProfiles) { profile in
                            HStack {
                                Text("\(profile.fullName)")
                                Spacer()
                                Image(systemName: "eye.fill")
                            }
                        }
                    }
                    .onAppear {
                        EventVM.getEventTrustedContactsProfiles(eventID: eventID)
                    }
                    
                    Section(header: Text(translationManager.eventdDetailsTrack)) {
                        Text("\(Text(translationManager.startTrack))  \(appState.event?.startTime.formatted(.dateTime) ?? "")")
                        Text("\(Text(translationManager.endTrack)) \(appState.event?.endTime.formatted(.dateTime) ?? "")")
                        Text("\(Text(translationManager.eventTypeTrack)) \(appState.event?.eventType ?? "")")
                        Text("\(Text(translationManager.otherTrack)) \(appState.event?.otherInfo ?? "")")
                    }
                    if !EventVM.isEventOwner() {
                        NavigationLink {
                            EventMapView()
                        } label: {
                            Text("View Tracked User On Map")
                        }
                    }
                }
                
            }
            
            // Modal showing a list of recorded messages from even onwer's speech
            Button { showingRecordedMessageView.toggle() } label: { Text("Show recorded messages") }
                .sheet(isPresented: $showingRecordedMessageView) { RecordedMessagesView() }
            
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
                }) {
                    TrackingModeButtonComponent()
                }
                : // User is in panic mode presses safe button
                Button(action: {
                    EventVM.disablePanicMode()
                }) {
                    TrackingModeButtonComponent()
                }
            } // end of Parent/Main VStack
            
          
        }
        //.navigationBarHidden(true)
        .onAppear {
            EventVM.getDetails(for: eventID)
            if EventVM.isEventOwner() { locationManager.locationDuringTrackingMode() }
        }
        

    }
    
}
