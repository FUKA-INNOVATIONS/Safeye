//
//  EventService.swift
//  Safeye
//
//  Created by SafeyeTeam on 1.4.2022.
//

/*
    This service handles communication between the database and the app State for event related functionalities
 
    1. Create a new entry in the database for a new event
    2. Returns the current authenticated users events and stores in app state
    3. Retrieves the events of the current users trusted contacts and stores in app state
    4. Uses the eventId to retieve the details of that event
    5. Update the details of the current event
    6. Updates the current events status when it detects the change in the viewModel
    7. Deletes the specified event
 */

import Foundation
import Firebase


class EventService {
    static let shared = EventService() ;  private init() {}
    private var eventDB = Firestore.firestore().collection("events")
    private let appState = Store.shared
    
    private var eventDetails: Event?
    @Published var eventErrors: String = ""
    
    
    func createEvent(_ event: Event) -> Bool {
        do {
            _ = try self.eventDB.addDocument(from: event)
            return true
        }
        catch {
            print(error)
            return false
        }
        
    } // end of createEvent
    
    
    // Returns users own events
    func fetchEventsForCurrentUser(userID: String) {
        DispatchQueue.main.async {
            self.eventDB.whereField("ownerId", isEqualTo: userID).addSnapshotListener() { event, error in
                if let error = error { print("Error in fetchEventForCurrentUser: \(error)") ; return }
                else {
                    self.appState.eventsOfCurrentUser.removeAll()
                    if event!.isEmpty { print("Current user has no event"); return }
                    if let event = event {
                        for event in event.documents {
                            print("Event of current user: \(event)")
                            do {
                                let convertedEvent = try event.data(as: Event.self)
                                self.appState.eventsOfCurrentUser.append(convertedEvent)
                            } catch {
                                print("Error fetchEventForCurrentUser 2: \(error)")
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    // Returns the events of trusted contacts
    func fetchEventsOfTrustedContacts(of userID: String) {
        DispatchQueue.main.async {
            self.eventDB.whereField("trustedContacts", arrayContains: userID)
                .addSnapshotListener() { event, error in
                    
                    if let error = error { print("Error in fetchEventsOfTrustedContacts: \(error)") ; return }
                    else {
                        self.appState.eventsOfTrustedContacts.removeAll()
                        if event!.isEmpty { print("fetchEventsOfTrustedContacts: Current user's trusted contacts have no events"); return }
                        if let event = event {
                            for event in event.documents {
                                print("Events of current trusted contacts: \(event)")
                                do {
                                    let convertedEvent = try event.data(as: Event.self)
                                    self.appState.eventsOfTrustedContacts.append(convertedEvent)
                                    // Remove event from panic list, for cases when panic mode is deactivated
                                    self.appState.eventsPanic = self.appState.eventsPanic.filter { $0.id != convertedEvent.id }
                                    if convertedEvent.status == .PANIC {
                                        self.appState.panicMode = true
                                        self.appState.eventsPanic = self.appState.eventsPanic.filter { $0.id != convertedEvent.id }
                                        self.appState.eventsPanic.append(convertedEvent)
                                    }
                                } catch {
                                    print("EventService: Error fetchEventsOfTrustedContacts: \(error)")
                                }
                            }
                        }
                    }
                }
        }
    }
    
    
    // Retrives the details of a specific event
    func fetchDetails(_ eventID: String) {
        let eventRef = self.eventDB.document(eventID)
        DispatchQueue.main.async {
            eventRef.addSnapshotListener() { document, error in
                if let error = error as NSError? {
                    self.eventErrors = "eventService: Error getting event: \(error.localizedDescription)"
                }
                else {
                    if let event = document {
                        do {
                            let convertedEvent =  try event.data(as: Event.self)
                            self.appState.event = convertedEvent
                            if convertedEvent.status == .PANIC {
                                self.appState.panicMode = true
                                for eventPanic in self.appState.eventsPanic {
                                    guard let currentUserID = AuthenticationService.getInstance.currentUser?.uid else { return }
                                    if eventPanic.id != convertedEvent.id && eventPanic.ownerId != currentUserID {
                                        self.appState.eventsPanic.append(convertedEvent)
                                    }
                                }
                            }
                            print("Fetched event: \(String(describing: self.appState.event))")
                        }
                        catch {
                            print(error)
                        }
                    }
                }
            }
        }
        // return listener
    } // end of getDetails
    
    
    func updateEvent(_ event: Event) {
        let eventRef = self.eventDB.document(event.id!)
        DispatchQueue.main.async {
            do {
                try eventRef.setData(from: event)
            }
            catch {
                print("Error in updateEvent \(error)")
            }
        }
    } // end of editEcent
    
    
    // Used when the users changes mode (panic <-> safe)
    func changeStatus(_ eventID: String, _ newStatus: EventStatus) {
        let eventRef = self.eventDB.document(eventID)
        
        eventRef.updateData(["status":newStatus.rawValue]) { err in
            if let err = err {
                print("Error changing event status: \(err)")
            } else {
                print("Event status successfully updated to: \(newStatus)")
            }
        }
    } // end of changeStatus
    
    
    
    func deleteEvent(_ eventID: String) {
        self.eventDB.document(eventID).delete() { error in
            if let error = error {
                print("Error deleting event: \(error)")
            } else {
                print("Event successfully deleted!")
            }
        }
    }
    
    
    
    func subscribeContact() {}
    
    func unsubscribeContact() {}
    
    // func getLocation() {}
    
    // func setLocation() {} // Use edit event
    
}

