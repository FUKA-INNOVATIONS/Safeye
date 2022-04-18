//
//  EventService.swift
//  Safeye
//
//  Created by FUKA on 1.4.2022.
//  Edited by FUKA on 11.4


import Foundation
import Firebase


class EventService {
    static let shared = EventService() ;  private init() {}
    private var eventDB = Firestore.firestore().collection("events")
    private let appState = Store.shared
    
    private var eventDetails: Event?
    @Published var eventErrors: String = ""
    
    
    /*func getEvent(_ eventID: String) -> Event? {
        self.fetchDetails(eventID)
        return self.eventDetails ?? nil
    } */
    
    /* func updateEvent(_ event: Event) {
        self.editEvent(event)
    } */ // end of updateEvent

    
    
    func createEvent(_ event: Event) -> Bool {
        do {
            _ = try eventDB.addDocument(from: event)
            return true
        }
        catch {
            print(error)
            return false
        }
        
    } // end of createEvent
    
    
    
    
    
    
    func fetchEventsForCurrentUser(userID: String) {
        self.eventDB.whereField("ownerId", isEqualTo: userID).getDocuments { event, error in
            if let error = error { print("Error in fetchEventForCurrentUser: \(error)") ; return }
            else {
                if event!.isEmpty { print("Current user has no event"); return }
                if let event = event {
                    for event in event.documents {
                        print("Event of current user: \(event)")
                        DispatchQueue.main.async {
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
    
    
    func fetchEventsOfTrustedContacts(userID: String) {
        self.eventDB.whereField("trustedContacts", arrayContains: userID)
            .getDocuments { event, error in
            
            if let error = error { print("Error in fetchEventsOfTrustedContacts: \(error)") ; return }
            else {
                if event!.isEmpty { print("fetchEventsOfTrustedContacts: Current user's trusted contacts have no events"); return }
                if let event = event {
                    for event in event.documents {
                        print("Events of current trusted contacts: \(event)")
                        DispatchQueue.main.async {
                            do {
                                let convertedEvent = try event.data(as: Event.self)
                                self.appState.eventsOfTrustedContacts.append(convertedEvent)
                            } catch {
                                print("EventService: Error fetchEventsOfTrustedContacts: \(error)")
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    
    func fetchDetails(_ eventID: String) {
        let eventRef = eventDB.document(eventID)
        
        eventRef.addSnapshotListener { document, error in
            if let error = error as NSError? {
                self.eventErrors = "eventService: Error getting event: \(error.localizedDescription)"
            }
            else {
                if let event = document {
                    DispatchQueue.main.async {
                        do {
                            let convertedEvent =  try event.data(as: Event.self)
                            self.appState.event = convertedEvent
                            if convertedEvent.status == .PANIC { self.appState.eventsPanic.append(convertedEvent) }
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
        let eventRef = eventDB.document(event.id!)
        DispatchQueue.main.async {
            do {
                try eventRef.setData(from: event)
            }
            catch {
                print("Error in updateEvent \(error)")
            }
        }
    } // end of editEcent
    
    
    func changeStatus(_ eventID: String, _ newStatus: EventStatus) {
        let eventRef = eventDB.document(eventID)
        
        eventRef.updateData(["status":newStatus.rawValue]) { err in
            if let err = err {
                print("Error changing event status: \(err)")
            } else {
                print("Event status successfully updated to: \(newStatus)")
            }
        }
    } // end of changeStatus
    
    func deleteEvent(_ eventID: String) {
        eventDB.document(eventID).delete() { error in
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

