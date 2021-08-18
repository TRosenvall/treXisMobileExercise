//
//  treXisMobileExerciseTests.swift
//  treXisMobileExerciseTests
//
//  Created by Timothy Rosenvall on 8/18/21.
//

import XCTest
@testable import treXisMobileExercise

class NetworkingTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNetworking_passingInvalidCharactersToEndpoint_ReceiveBadURLError() throws {
        //Arrange
        let systemUnderTest = Networking()
        
        //Act
        systemUnderTest.request(endpoint: "", httpMethod: "POST", parameters: []) { (result: NetworkingResult<Int, Error>?) in
            print(result)
        }
        
        //Assert
    }
}
