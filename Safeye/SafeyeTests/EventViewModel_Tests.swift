//
//  EventViewModel_Tests.swift
//  SafeyeTests
//
//  Created by iosdev on 27.4.2022.
//

import XCTest
@testable import Safeye
import Combine

class EventViewModel_Tests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

//    state.event = Event(id: "HBNB0TVomCoz6Wa0Vq1F", ownerId: "J1f1Guq0wAhTgrEP41Hrjm2aJBX2", status: EventStatus.STARTED, startTime: Date(), endTime: Date(), otherInfo: "", eventType: "night club", trustedContacts: ["w3sFXtvMyPQ76YKI2b0qyiVIVPO2"], audioFiles:[], coordinates: ["latitude": 454545, "longitude": 123343324], eventFolderPath: "events/D5778A33-4001-42EE-B8F1-4913D61BB2FF/", city: "Espoo", userMessage: [""])
    
    func test_EventViewModel_isEventOwner_shouldBeTrueIfUserIsOwner() {
        // Given
        let vm = EventViewModel.shared
        let state = Store.shared
        
        //When
        let expectation = XCTestExpectation(description: "Should return isOwner after 3 seconds")
        
        state.event = Event(id: "HBNB0TVomCoz6Wa0Vq1F", ownerId: "J1f1Guq0wAhTgrEP41Hrjm2aJBX2", status: EventStatus.STARTED, startTime: Date(), endTime: Date(), otherInfo: "", eventType: "night club", trustedContacts: ["w3sFXtvMyPQ76YKI2b0qyiVIVP02"], audioFiles:[], coordinates: ["latitude": 454545, "longitude": 123343324], eventFolderPath: "events/D5778A33-4001-42EE-B8F1-4913D61BB2FF/", city: "Espoo", userMessage: [""])
        
        state.$panicMode
            .sink { isOwner in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // Then
        wait(for: [expectation], timeout: 5)
    
        XCTAssertTrue(vm.isEventOwner())
    }
    
    func test_EventViewModel_getDetails_shouldReturnTrue() {
        // Given
        let vm = EventViewModel.shared
        let state = Store.shared
        
        //When
        let expectation = XCTestExpectation(description: "Should return event after 3 seconds")
        
        
        state.$panicMode
            .dropFirst()
            .sink { details in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        vm.getDetails(for: "HBNB0TVomCoz6Wa0Vq1F")
        
        // Then
        wait(for: [expectation], timeout: 5)
        
        XCTAssertTrue(state.event != nil)
    }
    
    func test_EventViewModel_changeStatus_shouldChangeStatusCorrectly() {
        // Given
        let vm = EventViewModel.shared
        let state = Store.shared
        
        //When
        let expectation = XCTestExpectation(description: "Should update status after 3 seconds")
        
        state.event = Event(id: "HBNB0TVomCoz6Wa0Vq1F", ownerId: "J1f1Guq0wAhTgrEP41Hrjm2aJBX2", status: EventStatus.STARTED, startTime: Date(), endTime: Date(), otherInfo: "", eventType: "night club", trustedContacts: ["w3sFXtvMyPQ76YKI2b0qyiVIVP02"], audioFiles:[], coordinates: ["latitude": 454545, "longitude": 123343324], eventFolderPath: "events/D5778A33-4001-42EE-B8F1-4913D61BB2FF/", city: "Espoo", userMessage: [""])
        
        state.$panicMode
            .dropFirst()
            .sink { panicMode in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        vm.changeStatus((state.event?.id)!, EventStatus.PANIC)
        
        // Then
        wait(for: [expectation], timeout: 5)
        
        XCTAssertTrue(state.panicMode)
    }
    
}
