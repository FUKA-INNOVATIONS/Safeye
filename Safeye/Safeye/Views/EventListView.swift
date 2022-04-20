//
//  EventListView.swift
//  Safeye
//
//  Created by FUKA on 17.4.2022.
//

import SwiftUI

struct EventListView: View {
    @EnvironmentObject var EventVM: EventViewModel
    @EnvironmentObject var appState: Store
    @State var showingCreateEvent = false
    
    var body: some View {
        VStack {
            Text("\(EventVM.getEventsCount()) events")
            Button { showingCreateEvent.toggle() } label: { Text("Create new event") }
                .sheet(isPresented: $showingCreateEvent) { CreateEventView() }
            Form {
                Section(header: Text("Your events (\(appState.eventsOfCurrentUser.count)) ")) {
                    ForEach(appState.eventsOfCurrentUser) { event in
                        let color = event.status == .PANIC ? Color.red : Color.green
                        
                        List {
                            NavigationLink { EventView(eventID: event.id!) } label: {
                                HStack {
                                    Text("\(event.eventType.capitalizingFirstLetter())")
                                        .foregroundStyle(color)
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
                
                Section(header: Text("Your friend's events (\(appState.eventsOfTrustedContacts.count)) ")) {
                    ForEach(appState.eventsOfTrustedContacts) { event in
                        let color = event.status == .PANIC ? Color.red : Color.green
                        NavigationLink {
                            EventView(eventID: event.id!)
                        } label: {
                            HStack {
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
            EventVM.getEventsOfCurrentUser()
            EventVM.getEventsOfTrustedContacts()
        }
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
