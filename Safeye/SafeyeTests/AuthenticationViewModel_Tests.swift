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
    let vm = AuthenticationViewModel.shared
    let appState = Store.shared
    
    let email = "fuad.kalhori@gmail.com"
    let password = "11111111"
    let expectation = XCTestExpectation(description: "Should sign in after 3 seconds")
    
    
    var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        // Make sure user is not signed in
        self.vm.signOut()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_AuthenticationViewModel_signIn_returnsTrueIfUserExists() throws {
        
        self.vm.$signedIn
            .dropFirst()
            .sink { signedIn in
                self.expectation.fulfill()
            }
            .store(in: &cancellables)
        
        self.vm.signIn(email: self.email, password: self.password)
        
        wait(for: [self.expectation], timeout: 5)
        
        XCTAssertTrue(self.vm.signedIn)
    }
    
    
    func test_Athentication_UserIsSignedIn_EmailStoredInAppState() throws {
        
        self.vm.$signedIn
            .dropFirst()
            .sink { signedIn in
                self.expectation.fulfill()
            }
            .store(in: &cancellables)
        
        self.vm.signIn(email: self.email, password: self.password)
        wait(for: [self.expectation], timeout: 5)
        
        XCTAssertEqual(self.email, self.appState.currentUserEmail)
        
    }
    
    func test_AuthenticationViewModel_signUp_returnsFalseSinceUserAlreadyExists() throws {
        self.vm.$signedIn
            .sink { signedIn in
                self.expectation.fulfill()
            }
            .store(in: &cancellables)
        
        self.vm.signUp(email: "NewUser@Test.fi", password: "Test123")
        
        wait(for: [self.expectation], timeout: 5)
        
        XCTAssertFalse(vm.signedIn)
        
    }
}
