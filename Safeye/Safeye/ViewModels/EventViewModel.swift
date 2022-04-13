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
    @Published var eventError: String = ""
    @Published var panicMode = false
    @Published var mode = "Tracking"

        // User presses panic mode
        func activatePanicMode() {
            print("Panic Mode activated")
            mode = "Panic"

            // TODO Panic Mode functionality #41 -> activate panic mode
        }

        // User pressed the safe button -> disabling panic mode
        func disablePanicMode() {
            print("Disabled panic mode")
            mode = "Tracking"

            // TODO Panic Mode functionality #41 -> disable panic mode
        }

        // User Pressed to disable tracking mode
        func disableTrackingMode() {
            print("Disabled tracking mode")

        }
    
    
    func createEvent(newEvent: Event) {
        print("Hello from create event")
        
        // Save event in database, returns true if succeeded
        let didCreateEvenet = eventService.createEvent(newEvent)
        
        didCreateEvenet ? print("EventVM -> New event succeeded") : print("EventVM -> New event failed")
        
    } // end of createEvent()
    
    
    
    // Get details for a specific event
    func getDetails(for eventID: String) {
        DispatchQueue.main.async {
            self.eventDetails =  self.eventService.getEvent(eventID)
        }
    }
    
    func updateEvent(_ event: Event) {
        self.eventService.updateEvent(event)
    }
    
    func editEvent() {}
    
    func deleteEvent() {}
    
    func changeStatus(_ eventID: String,_ newStatus: EventStatus) {
        if newStatus == EventStatus.PANIC {  DispatchQueue.main.async { self.panicMode = true  } }
        eventService.changeStatus(eventID, newStatus)
    }
    
    func subscribeContact() {}
    
    func unsubscribeContact() {}
    
    // func getLocation() {}
    
    func setLocation() {}
    
    func startListening() {}
    
    
    
}
