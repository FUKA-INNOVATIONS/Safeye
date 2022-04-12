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
    
    
    
    
    func editEvent() {}
    
    func deleteEvent() {}
    
    func changeStatus() {}
    
    func activatePanic() {}
    
    func subscribeContact() {}
    
    func unsubscribeContact() {}
    
    func getLocation() {}
    
    func setLocation() {}
    
}
