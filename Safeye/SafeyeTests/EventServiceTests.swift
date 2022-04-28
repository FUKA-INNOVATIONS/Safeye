//
//  EventServiceTests.swift
//  SafeyeTests
//
//  Created by FUKA on 28.4.2022.
//

import XCTest
@testable import Safeye


class EventServiceTests: XCTestCase {
    
    let appState = Store.shared
    let eventService = EventService.shared
    let authVM = AuthenticationViewModel.shared
    
    let expectation1 = XCTestExpectation(description: "Just wait for a while")
    let expectation2 = XCTestExpectation(description: "Just wait for a while")
    let expectation3 = XCTestExpectation(description: "Just wait for a while")
    let expectation4 = XCTestExpectation(description: "Just wait for a while")
    let expectation5 = XCTestExpectation(description: "Just wait for a while")
    let expectation6 = XCTestExpectation(description: "Just wait for a while")
    let expectation7 = XCTestExpectation(description: "Just wait for a while")
    
    
    
    
    let email = "fuad.kalhori@gmail.com"
    let password = "11111111"
    
    
    
    override func setUpWithError() throws {
        // Make sure right Fuad is logged in
        self.authVM.signOut()
        self.authVM.signIn(email: self.email, password: self.password)
    }

    override func tearDownWithError() throws {}
    
    

    func testCreateNewEventWithOneTrustedContactAndRetrieveItFromAppState() throws {
        self.expectation1.isInverted = true // the expectation is not intended to happen
        self.expectation2.isInverted = true // the expectation is not intended to happen
        self.expectation3.isInverted = true // the expectation is not intended to happen
        

        wait(for: [self.expectation1], timeout: 10)
        let currentUserFuad = self.authVM.getCurrentUser()
        
        let newEvent = Event(ownerId: currentUserFuad!.id!, status: .STARTED, startTime: Date(), endTime: Date(), otherInfo: "testInfo", eventType: "testType", trustedContacts: ["trustedContactId"], coordinates: ["testLongitude": 2.2222, "testLatitude": 3.3333], eventFolderPath: "testPath", city: "testCity")
        let isEventCreated = self.eventService.createEvent(newEvent)
        
        wait(for: [self.expectation3], timeout: 3)
        let filterCreatedEvent = self.appState.eventsOfCurrentUser.filter { $0.otherInfo == "testInfo" } // Filter current user's events from appState, create & add to db

        wait(for: [self.expectation2], timeout: 3)
        XCTAssertTrue(isEventCreated)
        XCTAssertGreaterThan(filterCreatedEvent.count, 0)
        
    }
    
    func testGetEventsOfCurrentUser_FromAppState_CreateAnEventToMakeSureUSerHasEvent() throws {
        self.expectation4.isInverted = true // the expectation is not intended to happen
        
        try? self.testCreateNewEventWithOneTrustedContactAndRetrieveItFromAppState() // create an event to make sure user has min. 1 event
        wait(for: [self.expectation4], timeout: 5) // used expectation4 beacause 1-3 is used in previous line
        
        let events = self.appState.eventsOfCurrentUser // Get current user's events from appState
        XCTAssertGreaterThan(events.count, 0)
    }
    
    func testFetchEventsOfCurrentUSerFromDatabaseAndRetireveThemFromAppState() throws{
        self.expectation4.isInverted = true // the expectation is not intended to happen
        self.expectation5.isInverted = true // the expectation is not intended to happen
        
        try? self.testCreateNewEventWithOneTrustedContactAndRetrieveItFromAppState() // create an event to make sure user has min. 1 event by creating a new one and adding to database
        wait(for: [self.expectation4], timeout: 5) // used expectation4 beacause 1-3 is used in previous line
        
        let currentUserFuad = self.authVM.getCurrentUser() // no need to wait here to make sure user is logged in since its done in prevously called function inside this function
        
        self.eventService.fetchEventsForCurrentUser(userID: currentUserFuad!.id!)
        
        wait(for: [self.expectation5], timeout: 5)
        let events = self.appState.eventsOfCurrentUser // Get current user's events from appState
        XCTAssertGreaterThan(events.count, 0)
        
    }
    
    func testDeleteAnEventAndConfirmDeletionFromAppState() throws{
        self.expectation1.isInverted = true // the expectation is not intended to happen
        self.expectation2.isInverted = true // the expectation is not intended to happen
        self.expectation3.isInverted = true // the expectation is not intended to happen
        self.expectation4.isInverted = true // the expectation is not intended to happen
        self.expectation5.isInverted = true // the expectation is not intended to happen
        
        let randomString = self.randomString(length: 10)

        wait(for: [self.expectation1], timeout: 10)
        let currentUserFuad = self.authVM.getCurrentUser()
        
        let newEvent = Event(ownerId: currentUserFuad!.id!, status: .STARTED, startTime: Date(), endTime: Date(), otherInfo: randomString, eventType: "deleteType", trustedContacts: ["trustedContactId"], coordinates: ["testLongitude": 2.2222, "testLatitude": 3.3333], eventFolderPath: "testPath", city: "testCity")
        _ = self.eventService.createEvent(newEvent)   // Creaate new event
        
        wait(for: [self.expectation2], timeout: 5)
        self.eventService.fetchEventsForCurrentUser(userID: currentUserFuad!.id!)
        
        wait(for: [self.expectation4], timeout: 5)
        let event = self.appState.eventsOfCurrentUser.filter { $0.otherInfo == randomString } // Get recently craeted event to confirm creation
        XCTAssertEqual(1, event.count) // Event creation succeeded
        
        let createdEventIdToDelete = event[0].id! // Get recently craeted event's id
        
        self.eventService.deleteEvent(createdEventIdToDelete) // delete recently craeted event from database
        wait(for: [self.expectation5], timeout: 5)
        
        let eventDeleted = self.appState.eventsOfCurrentUser.filter { $0.otherInfo == randomString } // make sure event was deleted from app state
        XCTAssertEqual(0, eventDeleted.count) // Event deletion succeeded, should return 0
        
        
    }
    
    
    func randomString(length: Int) -> String { // Generate random string
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    

}
