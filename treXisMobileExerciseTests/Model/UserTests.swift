//
//  UserTests.swift
//  treXisMobileExerciseTests
//
//  Created by Timothy Rosenvall on 8/22/21.
//

import XCTest
@testable import treXisMobileExercise

class UserTests: XCTestCase
{
    //MARK: - Constants and Variables
    var instanceUnderTest: User!

    //MARK: - Lifecycle Functions
    override func setUpWithError() throws
    {
        instanceUnderTest = User()
    }

    override func tearDownWithError() throws
    {
        instanceUnderTest = nil
    }
    
    //MARK: - Instance Tests
    func testUser_canCreateInstant_accountIsNotNil()
    {
        XCTAssertNotNil(instanceUnderTest)
    }
}
