//
//  CreateEventViewModel.swift
//  Safeye
//
//  Created by Safeye team on 6.4.2022.


/*
        This class is handling event related functionalities:

        1. Activating/deactivating panic mode
        2. Starting/stoping recording user speech during panic mode
        3. Calling the service to save recorded speech in the databse as text (every 5 secounds when user in panic mode)
        4. Sending local push notification to trusted contacts if a friend is in panic mode and they missed the notification in the app (trusted contact app is in background/screen locked)
        5. Checking if authenticated user is owner of currently active-on-screen/displayed event
        6. Chcking if user is one of trusted contacts of an event (currently displayed event)
        7. Creating a new event
        8. Getting amount of current user's events
        9. Updating an event
        10. Clearing list of selected contacts during event creation
        11. Changing status of a specific event. Used to activate and deactivate panic mode
        12. Deleting a specific event. Authenticated user can delete own events
 
 */


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
    
    // User presses panic mode, activate panic mode
    func activatePanicMode() {
        
        DispatchQueue.main.async {
            //self.appState.panicMode = true
            self.appState.event?.status = EventStatus.PANIC
            self.eventService.updateEvent(self.appState.event!)
        }
        
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
        locationManager.locationDuringTrackingMode()
        stopMonitoringSpeech()
        // TODO: remove notification
    }
    
    
    // Creates a new string every 5 second and adds it to an array to send  to database
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
            guard let currentUserID = AuthenticationService.getInstance.currentUser?.uid else { return }
            if panicEvent.ownerId != currentUserID {
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
    
    
    // Check if current user is owner of a currently active (on screen) event
    func isEventOwner() -> Bool {
        guard let currentUserID = AuthenticationService.getInstance.currentUser?.uid else { return false }
        return self.appState.event?.ownerId == currentUserID
    }
    
    
    //Not working properly, checks if user is one of trusted contacts of an event
    func isEventTrustedContact() -> Bool {
        guard let currentUserID = AuthenticationService.getInstance.currentUser?.uid else { return false }
        let selfFound = self.appState.event!.trustedContacts.filter { $0 == currentUserID }
        if !selfFound.isEmpty {
            print("ISISI: \(selfFound)")
            return true
        } else {
            return false
        }
    }
    
    
    // Create a new event
    func createEvent(_ startDate: Date, _ endDate: Date, _ otherInfo: String, _ eventType: String, _ eventCity: String, _ eventFolderPath: String ) -> Bool {
        guard let currentUserID = AuthenticationService.getInstance.currentUser?.uid else { return false }
        
        if self.appState.eventSelctedContacts.isEmpty { print("You must select atlest 1 contact") ; return false }
        
        let selectedContactIDS = appState.eventSelctedContacts.map { $0.userId }
        
        // TODO: MAX 5 contacts : firbase way to
        
        self.getEventsOfCurrentUser()
        //if self.appState.eventCurrentUser != nil {  print("Current user has an event so new event was not created") ; return false } // allow cretion of only 1 event
        
        print("SELECTED IDS: \(selectedContactIDS)")
        
        // create event folder
        fileService.putEventFolder(eventFolderPath: eventFolderPath)
        
        @State var coordinates: [String : Double] = ["longitude": Double(12334324), "latitude": Double(454545)]
        
        let newEvent = Event(ownerId: currentUserID, status: EventStatus.STARTED, startTime: startDate, endTime: endDate, otherInfo: otherInfo, eventType: eventType, trustedContacts: selectedContactIDS, coordinates: coordinates, eventFolderPath: eventFolderPath, city: eventCity)
        
        let didCreateEvent = eventService.createEvent(newEvent)
        didCreateEvent ? print("EventVM -> New event succeeded") : print("EventVM -> New event failed")
        return didCreateEvent
    } // end of createEvent()
    
    
    
    
    func getDetails(for eventID: String) { // Get details for a specific evens, result in appState.even
        self.eventService.fetchDetails(eventID)
        //let eventListener = self.eventService.fetchDetails(eventID)
        //return eventListener
    }
    
    func getEventsOfCurrentUser() {
        // Fetch all events of authenticated user, result in appState.eventsOfCurrentUser
        guard let currentUserID = AuthenticationService.getInstance.currentUser?.uid else { return }
        self.eventService.fetchEventsForCurrentUser(userID: currentUserID)
    }
    
    func getEventsOfTrustedContacts() {
        // Fetch all events of authenticated user, result in appState.eventsOfTrustedContacts
        guard let currentUserID = AuthenticationService.getInstance.currentUser?.uid else { return }
        self.eventService.fetchEventsOfTrustedContacts(of: currentUserID)
    }
    
    
    
    // Get trusted contacts of an event, result in appState.eventTrustedContactsProfiles
    func getEventTrustedContactsProfiles(eventID: String) {
        // self.appState.eventTrustedContactsProfiles.removeAll() // Creates issue, returns user back to eventListView from EventView
        DispatchQueue.main.async {
            self.profileService.fetchEventTrustedContactsProfiles(self.appState.event?.trustedContacts ?? [""])
        }
    }
    
    
    // Get ammount of events created by authenticated user
    func getEventsCount() -> Int {
        return self.appState.eventsOfCurrentUser.count + self.appState.eventsOfTrustedContacts.count
    }
    
    
    // Update an event
    func updateEvent(_ event: Event) {
        self.eventService.updateEvent(event)
    }
    
    
    // Clear list of selected contacts during event creation
    func resetEventSelectedContacts() {
        DispatchQueue.main.async {
            self.appState.eventSelctedContacts.removeAll()
        }
    }
    
    
    // Change status of a specific event
    func changeStatus(_ eventID: String,_ newStatus: EventStatus) {
        if newStatus == EventStatus.PANIC {  DispatchQueue.main.async { self.appState.panicMode = true  } }
        eventService.changeStatus(eventID, newStatus)
    }
    
    
    // Delete a specific event
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
