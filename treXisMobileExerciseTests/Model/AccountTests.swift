//
//  AccountTests.swift
//  treXisMobileExerciseTests
//
//  Created by Timothy Rosenvall on 8/22/21.
//

import XCTest
@testable import treXisMobileExercise

class AccountTests: XCTestCase
{
    //MARK: - Constants and Variables
    var instanceUnderTest: Account!

    //MARK: - Lifecycle Functions
    override func setUpWithError() throws
    {
        instanceUnderTest = Account(id: "1", name: "accountName", balance: 0.00)
    }

    override func tearDownWithError() throws
    {
        instanceUnderTest = nil
    }
    
    //MARK: - Instance Tests
    func testAccount_canCreateInstant_accountIsNotNil()
    {
        XCTAssertNotNil(instanceUnderTest)
    }
    
    func testAccount_idIsValid()
    {
        XCTAssertTrue(AccountController.isValidID(account: instanceUnderTest))
    }
    
    func testAccount_nameIsValid()
    {
        XCTAssertTrue(AccountController.isValidName(account: instanceUnderTest))
    }
}
