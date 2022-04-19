//
//  CreateEventViewModel.swift
//  Safeye
//
//  Created by FUKA on 1.4.2022.
//  Edited by FUKA on 11.4

import Foundation
import SwiftUI
import MapKit

class EventViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    static let shared = EventViewModel() ;  private override init() {}
    let eventService = EventService.shared
    private var appState = Store.shared
    private var connService = ConnectionService.shared
    private var profileService = ProfileService.shared
    private var fileService = FileService.shared
    
    
    //@Published var eventDetails: Event?
    //@Published var eventExists = false
    //@Published var didCreateEvent = false
    //@Published var eventError: String = ""
    //@Published var panicMode = false
    //@Published var mode = "Tracking"
    
    @StateObject private var notificationService = NotificationService()
    
    // Lines 30-77 location manager for tracking and panic mode
    var locationManager: CLLocationManager?
    
    // First checks loction permissions are allowed and created locationManager
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager?.delegate = self
            locationManager?.startUpdatingLocation()
            locationManager?.distanceFilter = 100
            locationManager?.allowsBackgroundLocationUpdates = true
            locationManager?.pausesLocationUpdatesAutomatically = false
            
            
        } else {
            print("Show Alert saying location not active")
        }
    }
    
    // Request always in use authorization so it can run in background
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }

        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        case .restricted:
            print("Your location is restricted")
        case .denied:
            print("You have denied this permission")
        case .authorizedAlways, .authorizedWhenInUse:
            break
        @unknown default:
            break
        }
    }
    
    // Reruns authorization check if permissions are changed
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    // Runs when a there is a location change specified by the distance filter
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLoc = locations.last else { return }
        if self.appState.event != nil {
            self.appState.event?.coordinates = ["latitude": userLoc.coordinate.latitude, "longitude": userLoc.coordinate.longitude]
            self.eventService.updateEvent(self.appState.event!)
        }
    }
    
    // User presses panic mode
    func activatePanicMode() {
        self.appState.panicMode = true
        self.appState.event?.status = EventStatus.PANIC
        self.eventService.updateEvent(self.appState.event!)
        //self.getEventsOfCurrentUser()
        locationManager?.distanceFilter = 1
        print("Panic Mode activated")
    }
    
    // User pressed the safe button -> disabling panic mode
    func disablePanicMode() {
        self.appState.panicMode = false
        self.appState.event?.status = EventStatus.STARTED
        self.eventService.updateEvent(self.appState.event!)
        //self.getEventsOfCurrentUser()
        locationManager?.distanceFilter = 100
        print("Disabled panic mode")
        
    }
    // Send notification about panic mode
    func sentNotification() {
        notificationService.createLocalNotification(title: "Safeye: Pavlo", body: "Panic mode activated") { error in
            print("error")
        }
        print("Notification sent")
    }
    
    // User Pressed to disable tracking mode
    func disableTrackingMode() {
        print("Disabled tracking mode")
        
        // TODO Stop updated location for locationManager
    }
    
    func isEventOwner() -> Bool {
        return self.appState.event?.ownerId == AuthenticationService.getInstance.currentUser!.uid
    }
    
    func isEventTrustedContact() -> Bool {//Not working properly, checks if user is one of trusted contacts of an event
        let selfFound = self.appState.event!.trustedContacts.filter { $0 == AuthenticationService.getInstance.currentUser!.uid }
        if !selfFound.isEmpty {
            print("ISISI: \(selfFound)")
            return true
        } else {
            return false
        }
    }
    
    
    func createEvent(_ startDate: Date, _ endDate: Date, otherInfo: String, eventType: String, eventFolderPath: String ) -> Bool {
        let currentUserID = AuthenticationService.getInstance.currentUser!.uid
        
        if self.appState.eventSelctedContacts.isEmpty { print("You must select atlest 1 contact") ; return false }
        
        let selectedContactIDS = appState.eventSelctedContacts.map { $0.userId }
        
        // TODO: MAX 5 contacts : firbase way to
        
        self.getEventsOfCurrentUser()
        //if self.appState.eventCurrentUser != nil {  print("Current user has an event so new event was not created") ; return false }
        
        print("SELECTED IDS: \(selectedContactIDS)")
        
        // create event folder
        fileService.putEventFolder(eventFolderPath: eventFolderPath)
        
       @State var coordinates: [String : Double] = ["longitude": Double(12334324), "latitude": Double(454545)]
        
        let newEvent = Event(ownerId: currentUserID, status: EventStatus.STARTED, startTime: startDate, endTime: endDate, otherInfo: otherInfo, eventType: eventType, trustedContacts: selectedContactIDS, coordinates: coordinates, eventFolderPath: eventFolderPath)
        
        let didCreateEvent = eventService.createEvent(newEvent)
        didCreateEvent ? print("EventVM -> New event succeeded") : print("EventVM -> New event failed")
        return didCreateEvent
        //return false
    } // end of createEvent()
    
    
    
    
    func getDetails(for eventID: String) { // Get details for a specific evens, result in appState.even
        self.eventService.fetchDetails(eventID)
            //let eventListener = self.eventService.fetchDetails(eventID)
            //return eventListener
    }
    
    func getEventsOfCurrentUser() {
        // Fetch all events of authenticated user, result in appState.eventsOfCurrentUser
        self.appState.eventsOfCurrentUser.removeAll()
        let currentUserId = AuthenticationService.getInstance.currentUser!.uid
        self.eventService.fetchEventsForCurrentUser(userID: currentUserId)
    }
    
    func getEventsOfTrustedContacts() {
        // Fetch all events of authenticated user, result in appState.eventsOfTrustedContacts
        self.appState.eventsOfTrustedContacts.removeAll()
        let currentUserId = AuthenticationService.getInstance.currentUser!.uid
        self.eventService.fetchEventsOfTrustedContacts(userID: currentUserId)
    }
    
    func getEventsAll() {
        DispatchQueue.main.async {
            self.getEventsOfTrustedContacts()
            self.getEventsOfCurrentUser()
        }
    }
    
    func getEventTrustedContactsProfiles(eventID: String) {
        // Get trusted contacts of an event, result in appState.eventTrustedContactsProfiles
        self.profileService.fetchEventTrustedContactsProfiles(self.appState.event?.trustedContacts ?? [""])
    }
    
    func getEventsCount() -> Int {
        return self.appState.eventsOfCurrentUser.count + self.appState.eventsOfTrustedContacts.count
    }
    
    
    
    
    func updateEvent(_ event: Event) {
        self.eventService.updateEvent(event)
    }
    
    
    /* func getEventCurrentUser() { // TODO: Delete
        let currentUserId = AuthenticationService.getInstance.currentUser!.uid
        self.eventService.fetchEventsForCurrentUser(userID: currentUserId)
    } */
    
    
    func resetEventSelectedContacts() {
        self.appState.eventSelctedContacts.removeAll()
    }
    
    /*func getCurrentEventTrustedContacts() {
        print(self.appState.eventCurrentUser!.trustedContacts)
        self.connService.fetchConnectionProfiles(self.appState.eventCurrentUser!.trustedContacts, eventCase: true)
    } */
    

    
    func changeStatus(_ eventID: String,_ newStatus: EventStatus) {
        if newStatus == EventStatus.PANIC {  DispatchQueue.main.async { self.appState.panicMode = true  } }
        eventService.changeStatus(eventID, newStatus)
    }
    
    
    func deleteEvent(_ eventID: String) {
        self.eventService.deleteEvent(eventID)
        DispatchQueue.main.async { self.appState.eventsOfCurrentUser = self.appState.eventsOfCurrentUser.filter { $0.id != eventID } }
    }
    
    func subscribeContact() {}
    
    func unsubscribeContact() {}
    
    func startListening() {}
    
    
    
}
