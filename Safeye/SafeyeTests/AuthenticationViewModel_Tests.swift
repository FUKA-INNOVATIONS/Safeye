//
//  AuthenticationViewModel_Tests.swift
//  SafeyeTests
//
//  Created by iosdev on 28.4.2022.
//

import XCTest
@testable import Safeye
import Combine

class AuthenticationViewModel_Tests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_AuthenticationViewModel_signIn_returnsTrueIfUserExists() {
        // Given
        let vm = AuthenticationViewModel.shared
        
        // When
        let expectation = XCTestExpectation(description: "Should sign in after 3 seconds")
        
        vm.$signedIn
            .dropFirst()
            .sink { signedIn in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        vm.signIn(email: "Unit@Testing.fi", password: "Test123")
        
        wait(for: [expectation], timeout: 5)
        
        XCTAssertTrue(vm.signedIn)
    }
    
    func test_AuthenticationViewModel_signUp_returnsFalseSinceUserAlreadyExists() {
        
            // Given
            let vm = AuthenticationViewModel.shared
        
            // When
            let expectation = XCTestExpectation(description: "Should fail to sign in after 3 seconds")
        
            vm.$signedIn
                .sink { signedIn in
                    expectation.fulfill()
                }
                .store(in: &cancellables)
        
            vm.signUp(email: "NewUser@Test.fi", password: "Test123")
            
            wait(for: [expectation], timeout: 5)
            
            XCTAssertFalse(vm.signedIn)
            
            
    }
}
