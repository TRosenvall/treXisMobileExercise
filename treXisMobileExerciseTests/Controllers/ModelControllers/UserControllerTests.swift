//
//  UserControllerTests.swift
//  treXisMobileExerciseTests
//
//  Created by Timothy Rosenvall on 8/22/21.
//

import XCTest
@testable import treXisMobileExercise

class UserControllerTests: XCTestCase {

    //MARK: - Constants and Variables
    var mockNetworkRequestProtocol: NetworkRequestProtocol!
    var mockAccountControllerProtocol: AccountControllerProtocol!
    var mockTransactionControllerProtocol: TransactionControllerProtocol!
    var instanceUnderTest: UserController!

    //MARK: - Lifecycle Functions
    override func setUpWithError() throws
    {
        self.mockNetworkRequestProtocol = MockNetworkRequest()
        self.mockAccountControllerProtocol = MockAccountController()
        self.mockTransactionControllerProtocol = MockTransactionController()
        instanceUnderTest = UserController(networkRequestProtocol: self.mockNetworkRequestProtocol,
                                           accountControllerProtocol: self.mockAccountControllerProtocol,
                                           transactionControllerProtocol: self.mockTransactionControllerProtocol)
        
    }

    override func tearDownWithError() throws
    {
        instanceUnderTest = nil
    }

    //MARK: - Instance Tests
    func testSetUsernameAndPassword_passInUsernameAndPassword_UserCredentialsSet()
    {
        //Arrange
        let username: String = "username"
        let password: String = "password"
        
        //Act
        instanceUnderTest.setUsernameAndPassword(username: username, password: password)
        
        //Assert
        XCTAssertEqual(instanceUnderTest.user.username, username)
        XCTAssertEqual(instanceUnderTest.user.password, password)
    }
    
    func testAuthenticateAndLogin_provideIncorrectParameterData_NetworkUsernameAndPasswordError()
    {
        //Arrange
        let parameters = [("password","pass123"), ("username","myUsername")] //Parameters within array are reversed.
        
        //Act
        //Testing on the NetworkRequest has shown that setting the port to the wrong port number will auto correct itself. This is a middleman function passing the port down and so knowing the port is inconsequestial.
        instanceUnderTest.authenticateAndLogin(port: "5555", parameters: parameters)
        { results in
            //Assert
            switch results
            {
            case .success(_):
                XCTFail("Incorrectly passing in the parameters will prevent the user from being logged in. They must be in the username and password order and format.")
            case .failure(let error):
                XCTAssertEqual(error, NetworkError.badUsernameOrPassword)
            }
        }
    }
    
    func testAuthenticateAndLogin_provideCorrectParameterData_NetworkUsernameAndPasswordError()
    {
        //Arrange
        let parameters = [("username","myUsername"), ("password","pass123")] //Parameters within array are reversed.
        
        //Act
        //Testing on the NetworkRequest has shown that setting the port to the wrong port number will auto correct itself. This is a middleman function passing the port down and so knowing the port is inconsequestial.
        instanceUnderTest.authenticateAndLogin(port: "5555", parameters: parameters)
        { results in
            //Assert
            switch results
            {
            case .success(_):
                XCTAssertTrue(self.instanceUnderTest.user.isAuthenticated)
            case .failure(_):
                XCTFail("Incorrectly passing in the parameters will prevent the user from being logged in. They must be in the username and password order and format.")
            }
        }
    }
    
    func testRetrieveAccounts_accountsShouldNotBeNil()
    {
        //Arrange
        instanceUnderTest.user.isAuthenticated = true
        
        //Act
        instanceUnderTest.retrieveAccounts { results in
            switch results {
            case .success(_):
                //Assert
                XCTAssertNotNil(self.instanceUnderTest.user.accounts)
            case.failure(_):
                XCTFail("If you've been authenticated, this test should never fail.")
            }
        }
    }
    
    func testRetrieveTransactions_transactionsShouldNotBeNil()
    {
        //Arrange
        instanceUnderTest.user.isAuthenticated = true
        let accountID = "1" //Test ID number for account
        
        //Act
        instanceUnderTest.retrieveAccountTransactions(accountID: accountID,
                                                      completion:
        { results in
            switch results
            {
            case .success(_):
                //Assert
                XCTAssertNotNil(self.instanceUnderTest.user.transactions)
            case.failure(_):
                XCTFail("If you've been authenticated, this test should never fail.")
            }
        })
    }
}
