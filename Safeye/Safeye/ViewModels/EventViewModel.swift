//
//  CreateEventViewModel.swift
//  Safeye
//
//  Created by FUKA on 1.4.2022.
//  Edited by FUKA

import Foundation
import SwiftUI
import CoreLocation

class EventViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    static let shared = EventViewModel() ;  private override init() {}
    let eventService = EventService.shared
    @ObservedObject private var appState = Store.shared
    private var connService = ConnectionService.shared
    private var profileService = ProfileService.shared
    private var fileService = FileService.shared
    private var notificationService = NotificationService.shared
    private var voiceClass = VoiceRecognizer.shared
    private var locationManager = LocationViewModel.shared
    
    @State private var isRecording = false
    
    var audioTimer : Timer?
    
    // User presses panic mode
    func activatePanicMode() {
//        print("COORDNATES: \(self.appState.event!.coordinates)")
        
        
        DispatchQueue.main.async {
            //self.appState.panicMode = true
            self.appState.event?.status = EventStatus.PANIC
            self.eventService.updateEvent(self.appState.event!)
        }
        //self.getEventsOfCurrentUser()
        //locationManager?.distanceFilter = 1
        locationManager.locationDuringPanicMode()
        
        // Timer function doesn't record first loop round
        self.voiceClass.reset()
        self.voiceClass.transcribe()
        self.isRecording = true
        
        monitorSpeechWhilstInPanicMode()
        print("Panic Mode activated")
    }
    
    // User pressed the safe button -> disabling panic mode
    func disablePanicMode() {
        DispatchQueue.main.async {
            self.appState.panicMode = false
            self.appState.event?.status = EventStatus.STARTED
            self.eventService.updateEvent(self.appState.event!)
            
            // Remove event from list of panic events
            //  self.appState.eventsPanic =  self.appState.eventsPanic.filter { $0.id != self.appState.event!.id }
        }
        //self.getEventsOfCurrentUser()
        //locationManager?.distanceFilter = 100
        locationManager.locationDuringTrackingMode()
        stopMonitoringSpeech()
        // TODO: remove notification
    }
    
    // Creates a new string every 15 second and adds it to an array to send  to database
    func monitorSpeechWhilstInPanicMode() {
        print("monitorSpeechWhilstInPanicMode 1")
        
        let date = Date() ;  let format = DateFormatter() ; format.dateFormat = "dd/MM HH:mm"
        let timestamp = format.string(from: date)
        
        var panicModeUserSpeech = "\(timestamp): "
        
        guard audioTimer == nil else { return }
        
        audioTimer =  Timer.scheduledTimer(withTimeInterval: TimeInterval(5), repeats: true) { timer in
            
            /**
                string is added at the start of timer so that the full 15 seconds of recorded audio is added
             */
            
//            panicModeUserSpeech.append("\(timestamp): \(self.voiceClass.userMessage)")
            
            panicModeUserSpeech += self.voiceClass.userMessage
            
            print(panicModeUserSpeech)
            
            print("monitorSpeechWhilstInPanicMode 2")
            // save user message (speech) in database
            self.appState.event!.userMessage.append(panicModeUserSpeech)
            print("monitorSpeechWhilstInPanicMode 3")
            self.eventService.updateEvent(self.appState.event!)
            print("monitorSpeechWhilstInPanicMode 4")
            
            self.voiceClass.reset()
            self.voiceClass.transcribe()
            self.isRecording = true

        }
    }
    
    /**
        Stops the timer function and stops listening for any audio
        runs when the user pressed the safe button
     */
    func stopMonitoringSpeech() {
        audioTimer?.invalidate()
        audioTimer = nil
        self.voiceClass.stopTranscribing()
        isRecording = false
    }
    
    // Send notification about panic mode
    func sendNotification() {
        print("Panic events count: \(self.appState.eventsPanic.count)")
        UNUserNotificationCenter.current().removeAllDeliveredNotifications() // For removing all delivered notification
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests() // For removing all pending notifications which are not delivered yet but scheduled.
//        if self.appState.panicMode {
            for panicEvent in self.appState.eventsPanic {
                profileService.fetchProfileByUserID(userID: panicEvent.ownerId, panicProfile: true) // fetch and set panic users profiles
                if panicEvent.ownerId != AuthenticationService.getInstance.currentUser!.uid {
                    for profile in self.appState.panicPofiles {
                        notificationService.createLocalNotification(title: "\(profile.fullName) needs help!", body: "Check current location and listen to the environment!") { error in
                            if error != nil {
                                print("sendNotification > error")
                                return
                            }
                        }
                    }
                }
            }
//        }
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
    
    
    func createEvent(_ startDate: Date, _ endDate: Date, _ otherInfo: String, _ eventType: String, _ eventCity: String, _ eventFolderPath: String ) -> Bool {
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
        
        let newEvent = Event(ownerId: currentUserID, status: EventStatus.STARTED, startTime: startDate, endTime: endDate, otherInfo: otherInfo, eventType: eventType, trustedContacts: selectedContactIDS, coordinates: coordinates, eventFolderPath: eventFolderPath, city: eventCity)
        
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
        //DispatchQueue.main.async { self.appState.eventsOfCurrentUser.removeAll() }
        let currentUserId = AuthenticationService.getInstance.currentUser!.uid
        self.eventService.fetchEventsForCurrentUser(userID: currentUserId)
    }
    
    func getEventsOfTrustedContacts() {
        // Fetch all events of authenticated user, result in appState.eventsOfTrustedContacts
        //DispatchQueue.main.async { self.appState.eventsOfTrustedContacts.removeAll() }
        let currentUserId = AuthenticationService.getInstance.currentUser!.uid
        self.eventService.fetchEventsOfTrustedContacts(of: currentUserId)
    }

    
    
    // Get trusted contacts of an event, result in appState.eventTrustedContactsProfiles
    func getEventTrustedContactsProfiles(eventID: String) {
        // self.appState.eventTrustedContactsProfiles.removeAll() // Creates issue, returns user back to eventListView from EventView
        DispatchQueue.main.async {
            self.profileService.fetchEventTrustedContactsProfiles(self.appState.event?.trustedContacts ?? [""])
        }
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
        DispatchQueue.main.async {
            self.appState.eventSelctedContacts.removeAll()
        }
    }
    
    /*func getCurrentEventTrustedContacts() {
        print(self.appState.eventCurrentUser!.trustedContacts)
        self.connService.fetchConnectionProfiles(self.appState.eventCurrentUser!.trustedContacts, eventCase: true)
    } */
    

    
    func changeStatus(_ eventID: String,_ newStatus: EventStatus) {
        if newStatus == EventStatus.PANIC {  DispatchQueue.main.async { self.appState.panicMode = true  } }
        eventService.changeStatus(eventID, newStatus)
    }
    
    
    func deleteEvent(offsets: IndexSet) {
        let eventID = offsets.map { self.appState.eventsOfCurrentUser[$0] }[0].id!
        self.eventService.deleteEvent(eventID)
        withAnimation {
            DispatchQueue.main.async { self.appState.eventsOfCurrentUser = self.appState.eventsOfCurrentUser.filter { $0.id != eventID } }
        }
    }
    
    func subscribeContact() {}
    
    func unsubscribeContact() {}
    
    func startListening() {}
    
    
    
}
