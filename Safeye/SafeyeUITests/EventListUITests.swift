//
//  EventListUITests.swift
//  SafeyeUITests
//
//  Created by FUKA on 28.4.2022.
//

import XCTest
//@testable import Safeye
//import Firebase

class EventListUITests: XCTestCase {
    let app = XCUIApplication()
    //let appState = Store.shared
    

    override func setUpWithError() throws {
        //FirebaseApp.configure() // Initialize Firebase
        app.launch()
        continueAfterFailure = false

    }

    override func tearDownWithError() throws {
    }
    
    func testAmountOfEventsTextIsDisplayed() throws {
        let eventsCountTextField = self.app.staticTexts["eventListViewEventsCountText"]
        XCTAssertTrue(eventsCountTextField.waitForExistence(timeout: 5))

        XCTAssertEqual(eventsCountTextField.label, "4 events")
        print("TESTTEST \(eventsCountTextField.label)")
    }
    
    func testAmountOfEventsTextIsDisplayed4() throws {
        let userEventsList = self.app.collectionViews["eventListViewEventsListOfAuthenticatedUser"]
        print("TESTTEST \(userEventsList.tables.element.accessibilityElementCount())")
    }
    
    func testCreateNewEventButtonCanBeTapped() throws {
        self.app.buttons["eventListViewCreateNewEventButton"].tap()
    }




}
