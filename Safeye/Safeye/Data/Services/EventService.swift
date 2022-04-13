//
//  EventService.swift
//  Safeye
//
//  Created by FUKA on 1.4.2022.
//  Edited by FUKA on 11.4


import Foundation
import Firebase // Import firebase


class EventService {
    // Get instance of Firestore database -> events colletion
    private var eventDB = Firestore.firestore().collection("events")
    private var eventDetails: Event?
    @Published var eventErrors: String = ""
    
    
    func getEvent(_ eventID: String) -> Event? {
        self.fetchDetails(eventID: eventID)
        return self.eventDetails ?? nil
    }
    
    /* enum ReturnType {
     case event(Event)
     case error(Bool)
     } */
    
    
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
    
    
    func updateEvent(_ event: Event) {
        self.editEvent(event)
    } // end of updateEvent
    
    
    
    private func fetchDetails(eventID: String) {
        let eventRef = eventDB.document(eventID)
        
        eventRef.getDocument { document, error in
            if let error = error as NSError? {
                self.eventErrors = "eventService: Error getting event: \(error.localizedDescription)"
            }
            else {
                if let document = document {
                    do {
                        self.eventDetails = try document.data(as: Event.self)
                        print("Fetched event: \(String(describing: self.eventDetails))")
                    }
                    catch {
                        print(error)
                    }
                }
            }
        }
    } // end of getDetails
    
    
    
    
    private func editEvent(_ event: Event) {
        let eventRef = eventDB.document(event.id!)
        do {
            try eventRef.setData(from: event)
        }
        catch {
            print(error)
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
    
    func deleteEvent() {}
    
    func subscribeContact() {}
    
    func unsubscribeContact() {}
    
    // func getLocation() {}            
    
    func setLocation() {}
    
}

