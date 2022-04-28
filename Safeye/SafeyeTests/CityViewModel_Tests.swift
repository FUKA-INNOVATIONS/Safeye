//
//  CityViewModel_Tests.swift
//  SafeyeTests
//
//  Created by iosdev on 28.4.2022.
//

import XCTest
@testable import Safeye
import Combine

class CityViewModel_Tests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_CityViewModel_getCities_shouldReturnListOfCitiesInFinland() {
        // Given
        let vm = CityViewModel.shared
        let state = Store.shared
        
        // When
        let expectation = XCTestExpectation(description: "Should return isOwner after 3 seconds")
        
        state.$citiesFinland
            .sink {cities in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        vm.getCities(of: "Finland")
        
        // Then
        wait(for: [expectation], timeout: 5)
    
        print(state.citiesFinland)
    }

    

}
