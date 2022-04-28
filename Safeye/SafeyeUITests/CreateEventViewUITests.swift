//
//  CreateEventViewUITests.swift
//  SafeyeUITests
//
//  Created by FUKA on 28.4.2022.
//

import XCTest

class CreateEventViewUITests: XCTestCase {

    let app = XCUIApplication()
    

    override func setUpWithError() throws {
        app.launch()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }
    
    func testTrustedContactAndEventTypeCanBeSelectedUITest() throws {
        self.app.buttons["eventListViewCreateNewEventButton"].tap()
        let tablesQuery = self.app.tables
        
        self.app.tables.scrollViews.children(matching: .other).element(boundBy: 0).children(matching: .other).element.tap()
        
        let eventTypeStaticText = tablesQuery.staticTexts["EVENT TYPE*"]
        eventTypeStaticText.swipeUp()
        tablesQuery.cells["dinner"].tap()
    }

    func testSomethingUITest() throws {                
    }
    


}
