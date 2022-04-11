//
//  CreateEventViewModel.swift
//  Safeye
//
//  Created by FUKA on 1.4.2022.
//  Edited by FUKA on 11.4

import Foundation
import SwiftUI

class EventViewModel: ObservableObject {
    let eventService = EventService()
    let userID = AuthenticationService.getInstance.currentUser!.uid
    
    @Published var eventDetails: Event?
    @Published var eventExists = false
    @Published var didCreateEvent = false
    
    
    func createEvent(
        _ startTime: Date,
        _ endTime: Date,
        _ otherInfo: String,
        _ trustedContacts: [String],
        _ coordinates: [String : Double]
    ) {
        print("Hello from create event")
        // Create new Event instance
        let newEvent = Event(ownerId: userID, status: EventStatus.STARTED, startTime: startTime, endTime: endTime, otherInfo: otherInfo, trustedContacts: trustedContacts, coordinates: coordinates)
        
        // Save event in database, returns true if succeeded
        let didCreateEvenet = eventService.createEvent(event: newEvent)
        
        
        if didCreateEvenet { // new event created, return object
            
        } else {
            print("ASDASDASDASDASDASDFASDASASDS")
        }
        
        /* if didCreateEvenet {
            self.didCreateEvent = true // creating new event succeeded
            // move to event view and pass id/object
            // newEvent.id = didCreateEvenet.documentID
        } else {
            self.didCreateEvent = false // creation failed
        } */
        
    } // end of createEvent()
    
    
    
    
    func getDetails() {}
    
    func editEvent() {}
    
    func deleteEvent() {}
    
    func changeStatus() {}
    
    func activatePanic() {}
    
    func subscribeContact() {}
    
    func unsubscribeContact() {}
    
    func getLocation() {}
    
    func setLocation() {}
    
    func startListening() {}
    
    
    
}
