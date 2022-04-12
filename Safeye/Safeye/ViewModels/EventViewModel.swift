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
    
    
    func createEvent(newEvent: Event) {
        print("Hello from create event")
        
        // Save event in database, returns true if succeeded
        let didCreateEvenet = eventService.createEvent(newEvent)
        
        didCreateEvenet ? print("EventVM -> New event succeeded") : print("EventVM -> New event failed")
        
    } // end of createEvent()
    
    
    
    
    func getDetails(for eventID: String) {
        DispatchQueue.main.async {
            self.eventDetails =  self.eventService.getEvent(eventID)
        }
    }
    
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
