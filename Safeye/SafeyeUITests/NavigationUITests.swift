//
//  NavigationUITests.swift
//  SafeyeUITests
//
//  Created by Koulu on 28.4.2022.
//

import XCTest

class NavigationUITests: XCTestCase {
    let app = XCUIApplication()
    

    override func setUpWithError() throws {
        app.launch()
        continueAfterFailure = false
        
    }

    override func tearDownWithError() throws {
    }
    

    func testUserCanNavigateToProfileViewUITest() throws {
        XCUIApplication().tabBars["Tab Bar"].buttons["Profile"].tap()
    }
    
    func testUserCanNavigateToSettingsViewUITest() throws {
        XCUIApplication().tabBars["Tab Bar"].buttons["Setting"].tap()
    }
    
    func testUserCanNavigateToConnectionsViewUITest() throws {
        XCUIApplication().tabBars["Tab Bar"].buttons["Connections"].tap()
    }
    
    func testUserCanNavigateHomeViewFromConnectionsViewViewUITest() throws {
        XCUIApplication().tabBars["Tab Bar"].buttons["Connections"].tap()
        XCUIApplication().tabBars["Tab Bar"].buttons["Home"].tap()
    }
    
    
    func testUserCanNavigateToSettingsViewAndChangeToLightThemeUITest() throws {
        XCUIApplication().tabBars["Tab Bar"].buttons["Setting"].tap()
        let tablesQuery = self.app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Light"]/*[[".cells[\"Light, Light, Dark, Dark\"]",".segmentedControls.buttons[\"Light\"]",".buttons[\"Light\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
    
    func testUserCanNavigateToSettingsViewAndChangeToDarktThemeUITest() throws {
        XCUIApplication().tabBars["Tab Bar"].buttons["Setting"].tap()
        let tablesQuery = self.app.tables
        tablesQuery.buttons["Dark"].tap()
    }
    
    func testUserCanNavigateAndDisplayPrivacyViewUITest() throws {
        XCUIApplication().tabBars["Tab Bar"].buttons["Setting"].tap()
        let tablesQuery = self.app.tables
        tablesQuery.cells["Privacy"].children(matching: .other).element(boundBy: 0).children(matching: .other).element.tap()
    }
    
    func testUserCanNavigateTosdsdConnectionsViewUITest() throws {
        
    }
    
}
