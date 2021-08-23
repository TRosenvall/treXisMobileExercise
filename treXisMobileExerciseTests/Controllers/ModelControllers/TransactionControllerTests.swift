//
//  TransactionControllerTests.swift
//  treXisMobileExerciseTests
//
//  Created by Timothy Rosenvall on 8/22/21.
//

import XCTest
@testable import treXisMobileExercise

class TransactionControllerTests: XCTestCase {

    //MARK: - Constants and Variables
    var mockNetworkRequestProtocol: NetworkRequestProtocol!
    var instanceUnderTest: TransactionController!
    let accountID = "anyAccountID"

    //MARK: - Lifecycle Functions
    override func setUpWithError() throws
    {
        self.mockNetworkRequestProtocol = MockNetworkRequest()
        instanceUnderTest = TransactionController(networkRequestProtocol: self.mockNetworkRequestProtocol)
    }

    override func tearDownWithError() throws
    {
        instanceUnderTest = nil
    }

    //MARK: - Instance Tests
    func testGetTransactions_notAuthenticated_networkAuthenticationError() {
        //Act
        instanceUnderTest.getTransactions(isAuthenticated: false, accountID: self.accountID)
        { results in
            switch results
            {
            //Assert
            case .success(_):
                XCTFail("If not authenticated, user should not retrieve data")
            case .failure(let error):
                XCTAssertEqual(error, NetworkError.authenticationError)
            }
        }
    }
    
    func testGetTransactions_isAuthenticated_accountsNotNil() {
        instanceUnderTest.getTransactions(isAuthenticated: true, accountID: self.accountID)
        { results in
            switch results
            {
            case .success(let accounts):
                XCTAssertNotNil(accounts)
            case .failure(_):
                XCTFail("If authenticated, accounts should be received from server.")
            }
        }
    }
}
