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
    
    func createEvent(event: Event) -> Bool {
        let created = eventDB.addDocument(data: [
            
            
            "ownerId": event.ownerId,
            "status": event.status.rawValue,
            "startTime": event.startTime,
            "endTime": event.endTime,
            "otherInfo": event.otherInfo,
            "trustedContacts": event.trustedContacts,
            "coordinates": event.coordinates,
            
        ], completion: { error in
            
            if let error = error {
                print("Error creating event: \(error)")
                return
            } else {
                print("Event successfully created!")
            }
        })
        // print("CREATED: \(created.documentID)")
        return true
        
    } // end of createEvent
    
    
    
    func getDetails() {}
    
    func editEvent() {}
    
    func deleteEvent() {}
    
    func changeStatus() {}
    
    func activatePanic() {}
    
    func subscribeContact() {}
    
    func unsubscribeContact() {}
    
    func getLocation() {}
    
    func setLocation() {}
    
}
