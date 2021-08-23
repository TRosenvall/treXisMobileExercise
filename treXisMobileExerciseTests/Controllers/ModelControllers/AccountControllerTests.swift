//
//  AccountControllerTests.swift
//  treXisMobileExerciseTests
//
//  Created by Timothy Rosenvall on 8/22/21.
//

import XCTest
@testable import treXisMobileExercise

class AccountControllerTests: XCTestCase {

    //MARK: - Constants and Variables
    var mockNetworkRequestProtocol: NetworkRequestProtocol!
    var instanceUnderTest: AccountController!

    //MARK: - Lifecycle Functions
    override func setUpWithError() throws
    {
        self.mockNetworkRequestProtocol = MockNetworkRequest()
        instanceUnderTest = AccountController(networkRequestProtocol: self.mockNetworkRequestProtocol)
    }

    override func tearDownWithError() throws
    {
        instanceUnderTest = nil
    }

    //MARK: - Instance Tests
    func testGetAccounts_notAuthenticated_networkAuthenticationError() {
        //Act
        instanceUnderTest.getAccounts(isAuthenticated: false)
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
    
    func testGetAccounts_isAuthenticated_accountsNotNil() {
        //Act
        instanceUnderTest.getAccounts(isAuthenticated: true)
        { results in
            switch results
            {
            //Assert
            case .success(let accounts):
                XCTAssertNotNil(accounts)
            case .failure(_):
                XCTFail("If authenticated, accounts should be received from server.")
            }
        }
    }
}
