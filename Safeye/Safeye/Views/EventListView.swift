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
    
    var translationManager = TranslationService.shared
    
    var body: some View {
        VStack {
            Text("\(EventVM.getEventsCount()) \(Text(translationManager.eventsNumber))")
            Button { showingCreateEvent.toggle() } label: { Text(translationManager.createNewEventBtn) }
                .sheet(isPresented: $showingCreateEvent) { CreateEventView() }
            Form {
                Section(header: Text(" \(Text(translationManager.yourEventsTitle)) (\(appState.eventsOfCurrentUser.count)) ")) {
                    ForEach(appState.eventsOfCurrentUser) { event in
                        let color = event.status == .PANIC ? Color.red : Color.green
                        
                        Group {
                            NavigationLink { EventView(eventID: event.id!) } label: {
                                HStack {
                                    Text("\(event.eventType.capitalizingFirstLetter())")
                                        .foregroundStyle(color)
                                    Spacer()
                                    Text("\(event.startTime.formatted(.dateTime))")
                                        .font(.caption)
                                }
                            }
                            
                            HStack {
                                Image(systemName: "minus.circle.fill")
                                Spacer()
                                Text("\(event.status.rawValue)")
                                Spacer()
                                HStack {
                                    Text("\(event.trustedContacts.count)")
                                    Image(systemName: "eye")
                                }
                            }
                            
                            
                        }
                        
                        Spacer(minLength: 30)
                        
                    }
                }
                 
                Section(header: Text(" \(Text(translationManager.yourFriendsEventsTitle)) (\(appState.eventsOfTrustedContacts.count)) ")) {
                     ForEach(appState.eventsOfTrustedContacts) { event in
                         let color = event.status == .PANIC ? Color.red : Color.green
                         NavigationLink {
                             EventView(eventID: event.id!)
                         } label: {
                             HStack {
                                 Text("\(event.eventType.capitalizingFirstLetter())")
                                     .foregroundStyle(color)
                                 Text("\(event.startTime.formatted(.dateTime))")
                                     .font(.caption)
                                 Spacer()
                                 HStack {
                                     Text("\(event.trustedContacts.count)")
                                     Image(systemName: "eye")
                                 }
                             }
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
