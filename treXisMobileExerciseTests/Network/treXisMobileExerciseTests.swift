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

    func testNetworking_passingIncorrectUsernameOrPassword_ReceiveStatusCode404() throws {
        //Arrange
        let networkingResult: NetworkingResult<Int, Error>? = NetworkingResult.statusCode(404)
        //let expectation = expectation(description: "Awaiting Networking Result")
        
        //Act
        Networking.request(endpoint: "", httpMethod: "POST", parameters: []) { (results: NetworkingResult<Int, Error>?) in
            
            if let results = results,
               case .statusCode(let result) = results {
                //expectation.fulfill()
                print(result)
                //Assert
                //XCTAssertEqual(result, networkingResult)
            }
        }
        
        //waitForExpectations(timeout: 5, handler: nil)
    }
}
