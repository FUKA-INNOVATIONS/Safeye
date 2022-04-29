//
//  ProfileService_Tests.swift
//  SafeyeTests
//
//  Created by iosdev on 26.4.2022.
//

import XCTest
@testable import Safeye
import Combine
import CoreLocation


class ProfileViewModel_Tests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_ProfileViewModel_getProfileForCurrentUser_shouldAddProfileToAppState() {
        // Given
        let vm = ProfileViewModel.shared
        let state = Store.shared
        
        // When
        let expectation = XCTestExpectation(description: "Should return profile after 3 seconds")
        
        state.$profile
            .dropFirst()
            .sink { returnedProfile in
                expectation.fulfill()
            }
            .store(in: &cancellables)

        vm.getProfileForCurrentUser()
        
        // Then
        wait(for: [expectation], timeout: 5)
        
        XCTAssertTrue((state.profile != nil))
    }

    func test_ProfileViewModel_createProfile_shouldCreateNewProfile() {
        // Given
        let vm = ProfileViewModel.shared
        let state = Store.shared
        
        // When
        let expectation = XCTestExpectation(description: "Should create new profile after 3 seconds")
        
        state.$profile
            .dropFirst()
            .sink { createdProfile in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        vm.createProfile("New User", "New Address", "010101", "A", "None", "None", "No Avatar")
        
        // Then
        wait(for: [expectation], timeout: 5)
        
        XCTAssertTrue(state.profile != nil)
    }

}
