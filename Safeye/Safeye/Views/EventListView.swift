//
//  EventListView.swift
//  Safeye
//
//  Created by FUKA on 17.4.2022.
//

import SwiftUI

struct EventListView: View {
    @EnvironmentObject var EventVM: EventViewModel
    @EnvironmentObject var ConnectionVM: ConnectionViewModel
    @EnvironmentObject var appState: Store
    var translationManager = TranslationService.shared
    @State var showingCreateEvent = false
    
    
    
    var body: some View {
        //EventVM.sendNotification()
        
        return VStack {
            VStack {
//                Text("\(EventVM.getEventsCount()) events")
                Text("\(EventVM.getEventsCount()) \(Text(translationManager.eventsNumber))")
                Spacer()
//                Button { showingCreateEvent.toggle() } label: { Text("Create new event") }
                Button { showingCreateEvent.toggle() } label: { Text(translationManager.createNewEventBtn) }
                    .sheet(isPresented: $showingCreateEvent) { CreateEventView() }
                Form {
//                    Section(header: Text("Your events (\(appState.eventsOfCurrentUser.count)) ")) {
                    Section(header: Text(" \(Text(translationManager.yourEventsTitle)) (\(appState.eventsOfCurrentUser.count)) ")) {                        ForEach(appState.eventsOfCurrentUser) { event in
                            let color = event.status == .PANIC ? Color.red : Color.green
                            
                            List {
                                NavigationLink { EventView(eventID: event.id!) } label: {
                                    HStack {
                                        Text("\(event.eventType.capitalizingFirstLetter())")
                                            .foregroundStyle(color)
                                            .onTapGesture { EventVM.getEventTrustedContactsProfiles(eventID: event.id!) }
                                        Spacer()
                                        Text(event.startTime, style: .date)
                                            .font(.caption)
                                        Spacer()
                                        Text("\(event.trustedContacts.count)")
                                        Image(systemName: "eye")
                                    }
                                    .frame(height: 60)
                                    
                                }
                                
                            }
                        }
                        .onDelete(perform: EventVM.deleteEvent)
                    }
                    
//                    Section(header: Text("Your friend's events (\(appState.eventsOfTrustedContacts.count)) ")) {
                    Section(header: Text(" \(Text(translationManager.yourFriendsEventsTitle)) (\(appState.eventsOfTrustedContacts.count)) ")) {
                        ForEach(appState.eventsOfTrustedContacts) { event in
                            let color = event.status == .PANIC ? Color.red : Color.green
                            //let panicIcon =  event.status == .PANIC ? Image(systemName: "exclamationmark.triangle.fill").font(.system(size: 23, weight: .bold)) : EmptyView()
                            NavigationLink {
                                EventView(eventID: event.id!)
                            } label: {
                                HStack {
                                    //event.status == .PANIC ? Image(systemName: "exclamationmark.triangle.fill").font(.system(size: 23, weight: .bold)) : EmptyView()
                                    Text("\(event.eventType.capitalizingFirstLetter())")
                                        .foregroundStyle(color)
                                    Spacer()
                                    Text(event.startTime, style: .date)
                                        .font(.caption)
                                    Spacer()
                                    HStack {
                                        Text("\(event.trustedContacts.count)")
                                        Image(systemName: "eye")
                                    }
                                }
                                .frame(height: 60)
                            }
                            
                        }
                        
                    }
                }
            }
            .onAppear {
                print("eventList view appeared")
//                ConnectionVM.getConnections()
//                EventVM.getEventsOfCurrentUser()
//                EventVM.getEventsOfTrustedContacts()
                EventVM.sendNotification()
                ConnectionVM.getConnections()
                ConnectionVM.getConnectionProfiles()
                ConnectionVM.getPendingRequests()
                EventVM.getEventsOfCurrentUser()
                EventVM.getEventsOfTrustedContacts()
            
            }
        } // end of outer VStack
    }
}

struct EventListView_Previews: PreviewProvider {
    static var previews: some View {
        EventListView()
    }
}



/**
 
 
 .toolbar {
     ToolbarItem(placement: .navigationBarTrailing) {
         EditButton()
     }
     ToolbarItem {
         Button(action: { showingCreateEvent = true }) {
             Label("Create new event", systemImage: "plus")
         }
     }
 }
 
 
 */
