//
//  TransactionTests.swift
//  treXisMobileExerciseTests
//
//  Created by Timothy Rosenvall on 8/22/21.
//

import XCTest
@testable import treXisMobileExercise

class TransactionTests: XCTestCase
{
    //MARK: - Constants and Variables
    var instanceUnderTest: Transaction!

    //MARK: - Lifecycle Functions
    override func setUpWithError() throws
    {
        instanceUnderTest = Transaction(id: "1", title: "transactionTitle", balance: 0.00)
    }

    override func tearDownWithError() throws
    {
        instanceUnderTest = nil
    }
    
    //MARK: - Instance Tests
    func testTransaction_canCreateInstant_accountIsNotNil()
    {
        XCTAssertNotNil(instanceUnderTest)
    }
    
    func testTransaction_idIsValid()
    {
        XCTAssertTrue(TransactionController.isValidID(transaction: instanceUnderTest))
    }
    
    func testTransaction_nameIsValid()
    {
        XCTAssertTrue(TransactionController.isValidTitle(transaction: instanceUnderTest))
    }
}
