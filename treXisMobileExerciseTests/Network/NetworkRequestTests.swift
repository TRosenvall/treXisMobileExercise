//
//  NetworkRequestTests.swift
//  treXisMobileExerciseTests
//
//  Created by Timothy Rosenvall on 8/21/21.
//

import XCTest
@testable import treXisMobileExercise

class NetworkRequestTests: XCTestCase
{
    ///I know that I'm lacking in full understanding of the URLSession and how it works. I also know that there are ways to get
    ///errors that I'm not familiar with. To this end, I've tested against all the cases I've run into. I'm sure this is not
    ///exhaustive, but I'm not sure what else to test here.
    //MARK: - Constants and Variables
    var mockURLSession: MockURLSession!
    var instanceUnderTest: NetworkRequest!
    let baseURL = "http://localhost:"
    let defaultPort = "5555"

    //MARK: - Lifecycle Functions
    override func setUpWithError() throws
    {
        self.mockURLSession = MockURLSession()
        instanceUnderTest = NetworkRequest(urlSessionProtocol: self.mockURLSession)
        
    }

    override func tearDownWithError() throws
    {
        //NOP
    }

    //MARK: - Instance Tests
    func testPortDidSet_WithNumericCharacters_WillUpdateURLWithPort() throws
    {
        //Arrange
        let port = "5555"
        
        //Act
        instanceUnderTest.port = port
        
        //Assert
        XCTAssertEqual(self.baseURL + port, instanceUnderTest.baseURLWithPort)
    }
    
    func testPortDidSet_WithNonNumericCharacters_WillNotUpdateFromDefaultPort() throws
    {
        //Arrange
        let port = "5as"
        
        //Act
        instanceUnderTest.port = port
        
        //Assert
        XCTAssertNotEqual(self.baseURL + port, instanceUnderTest.baseURLWithPort)
        XCTAssertEqual(self.baseURL + defaultPort, instanceUnderTest.baseURLWithPort)
    }
    
    func testPortDidSet_WithNewPortNumber_WillNotUpdateFromDefaultPort() throws
    {
        //Arrange
        let port = "5554"
        
        //Act
        instanceUnderTest.port = port
        
        //Assert
        XCTAssertEqual(self.baseURL + port, instanceUnderTest.baseURLWithPort)
    }
    
    func testPingFunction_withWorkingPort_resultWillReturnTrue()
    {
        //Arrange
        //Asyncronous Expectation Set
        let expectation = self.expectation(description: "Pinging Server")
        //Reset the baseURLWithPort variable to the default port
        instanceUnderTest.port = self.defaultPort
        //Response which should be received at network call.
        let url = URL(string: instanceUnderTest.baseURLWithPort)!
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        let urlSession = MockURLSession(data: nil, urlResponse: response, error: nil)
        instanceUnderTest.urlSessionProtocol = urlSession
        
        //Act
        //Function to be tested
        instanceUnderTest.ping
        { results in
            switch results
            {
            case .success(let result):
                //Assert
                XCTAssertTrue(result)
            case .failure(_):
                XCTFail("Passed in URLResponse, this code should not be called.")
            }
            //Fulfill expectations.
            expectation.fulfill()
        }

        //Wait for expectations to be fulfilled
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testPingFunction_withFailingPort_resultWillReturnNetworkErrorBadPort()
    {
        //Arrange
        //Asyncronous Expectation Set
        let expectation = self.expectation(description: "Pinging Server")
        //Reset the baseURLWithPort to a failing port
        let failingPort = "5554"
        instanceUnderTest.port = failingPort
        //Set the urlSession to invoke completion with the expected response.
        let urlSession = MockURLSession(data: nil, urlResponse: nil, error: NetworkError.badPort)
        instanceUnderTest.urlSessionProtocol = urlSession
        
        //Act
        //Function to be tested
        instanceUnderTest.ping
        { results in
            switch results
            {
            case .success(_):
                //Assert
                XCTFail("Passed in NetworkError, this code should not be called.")
            case .failure(let result):
                XCTAssertEqual(result, NetworkError.badPort)
            }
            //Fulfill expectations.
            expectation.fulfill()
        }

        //Wait for expectations to be fulfilled
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testLogin_passInCorrectParameters_ResultsWithTrue()
    {
        //Arrange
        //Asyncronous Expectation Set
        let expectation = self.expectation(description: "Pinging Server")
        //Reset the baseURLWithPort to the default port
        instanceUnderTest.port = self.defaultPort
        //Set correct parameters
        let parameters = [("username","Username"), ("password","Password")]
        //Response which should be received at network call.
        let url = URL(string: instanceUnderTest.baseURLWithPort)!
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        let urlSession = MockURLSession(data: nil, urlResponse: response, error: nil)
        instanceUnderTest.urlSessionProtocol = urlSession
        
        //Act
        //Function to be tested
        instanceUnderTest.login(parameters: parameters, completion:
        { results in
            switch results
            {
            case .success(let result):
                //Assert
                XCTAssertTrue(result)
            case .failure(_):
                XCTFail("Passed in HTTPURLResponse with statusCode 200, this code should not be called.")
            }
            //Fulfill expectations.
            expectation.fulfill()
        })

        //Wait for expectations to be fulfilled
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testLogin_passInWrongParameters_ResultsWithTrue()
    {
        //Arrange
        //Asyncronous Expectation Set
        let expectation = self.expectation(description: "Pinging Server")
        //Reset the baseURLWithPort to the default port
        instanceUnderTest.port = self.defaultPort
        //Set correct parameters
        let parameters = [("password","Password"), ("username","Username")]
        //Response which should be received at network call.
        let url = URL(string: instanceUnderTest.baseURLWithPort)!
        let response = HTTPURLResponse(url: url, statusCode: 404, httpVersion: nil, headerFields: nil)
        let urlSession = MockURLSession(data: nil, urlResponse: response, error: nil)
        instanceUnderTest.urlSessionProtocol = urlSession
        
        //Act
        //Function to be tested
        instanceUnderTest.login(parameters: parameters, completion:
        { results in
            switch results
            {
            case .success(_):
                //Assert
                XCTFail("Passed in URLResponse with statusCode 404, this code should not be called.")
            case .failure(let result):
                XCTAssertEqual(result, NetworkError.badUsernameOrPassword)
            }
            //Fulfill expectations.
            expectation.fulfill()
        })

        //Wait for expectations to be fulfilled
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetGenericModel_passInIsAuthenticatedFalse_willReceiveNetworkErrorAuthenticationError()
    {
        //Arrange
        //Asyncronous Expectation Set
        let expectation = self.expectation(description: "Pinging Server")
        //Reset the baseURLWithPort to the default port
        instanceUnderTest.port = self.defaultPort
        //Set correct parameters
        let isAuthenticated = false
        //No network call made if not authenticated
        let endpoint = "/endpoint"
        let parameters: [(String, Any)] = []
        
        //Act
        //Function to be tested
        instanceUnderTest.getGenericModel(typeOf: [MockModel].self, isAuthenticated: isAuthenticated, endpoint: endpoint, parameters: parameters)
        { (results: Result<[MockModel], NetworkError>?) in
            switch results
            {
            case .success(_):
                //Assert
                XCTFail("No Network call should be made if isAuthenticated is false. No model should be returned.")
            case .failure(let result):
                XCTAssertEqual(result, NetworkError.authenticationError)
            case .none:
                XCTFail("Results should never return in this case.")
            }
            //Fulfill expectations.
            expectation.fulfill()
        }

        //Wait for expectations to be fulfilled
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetGenericModel_passInBadEndpoint_willReceiveNetworkErrorTransportError()
    {
        //Arrange
        //Asyncronous Expectation Set
        let expectation = self.expectation(description: "Pinging Server")
        //Reset the baseURLWithPort to the default port
        instanceUnderTest.port = self.defaultPort
        //Set correct parameters
        let isAuthenticated = true
        //No network call made if not authenticated
        let endpoint = "/badEndpoint"
        let parameters: [(String, Any)] = []
        //Response which should be received at network call.
        let urlSession = MockURLSession(data: nil, urlResponse: nil, error: NetworkError.transportError)
        instanceUnderTest.urlSessionProtocol = urlSession
        
        //Act
        //Function to be tested
        instanceUnderTest.getGenericModel(typeOf: [MockModel].self, isAuthenticated: isAuthenticated, endpoint: endpoint, parameters: parameters)
        { (results: Result<[MockModel], NetworkError>?) in
            switch results
            {
            case .success(_):
                //Assert
                XCTFail("No model should be returned.")
            case .failure(let result):
                XCTAssertEqual(result, NetworkError.transportError)
            case .none:
                XCTFail("Results should never return in this case.")
            }
            //Fulfill expectations.
            expectation.fulfill()
        }

        //Wait for expectations to be fulfilled
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetGenericModel_passInBadParameters_willReceiveNetworkErrorTransportError()
    {
        //Arrange
        //Asyncronous Expectation Set
        let expectation = self.expectation(description: "Pinging Server")
        //Reset the baseURLWithPort to the default port
        instanceUnderTest.port = self.defaultPort
        //Set correct parameters
        let isAuthenticated = true
        //No network call made if not authenticated
        let endpoint = "/endpoint"
        let parameters: [(String, Any)] = [("Bad","Parameter")]
        //Response which should be received at network call.
        let urlSession = MockURLSession(data: nil, urlResponse: nil, error: NetworkError.transportError)
        instanceUnderTest.urlSessionProtocol = urlSession
        
        //Act
        //Function to be tested
        instanceUnderTest.getGenericModel(typeOf: [MockModel].self, isAuthenticated: isAuthenticated, endpoint: endpoint, parameters: parameters)
        { (results: Result<[MockModel], NetworkError>?) in
            switch results
            {
            case .success(_):
                //Assert
                XCTFail("No model should be returned.")
            case .failure(let result):
                XCTAssertEqual(result, NetworkError.transportError)
            case .none:
                XCTFail("Results should never return in this case.")
            }
            //Fulfill expectations.
            expectation.fulfill()
        }

        //Wait for expectations to be fulfilled
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetGenericModel_passInCorrectValues_willReceiveDecodedModel()
    {
        //Arrange
        //Asyncronous Expectation Set
        let expectation = self.expectation(description: "Pinging Server")
        //Reset the baseURLWithPort to the default port
        instanceUnderTest.port = self.defaultPort
        //Set correct parameters
        let isAuthenticated = true
        //No network call made if not authenticated
        let endpoint = "/endpoint"
        let parameters: [(String, Any)] = [("Good","Parameter")]
        //Build models to test
        let mockModel1 = MockModel(id: "1", name: "mockModel1", balance: 0.00)
        let mockModel2 = MockModel(id: "2", name: "mockModel2", balance: 0.00)
        let mockModels: [MockModel] = [mockModel1, mockModel2]
        //Encode the models as data
        do
        {
            let data = try JSONEncoder().encode(mockModels)
            let urlSession = MockURLSession(data: data, urlResponse: nil, error: nil)
            instanceUnderTest.urlSessionProtocol = urlSession
        }
        catch
        {
            print("JSONEncoding Error in NetworkRequestTests")
        }
        
        //Act
        //Function to be tested
        instanceUnderTest.getGenericModel(typeOf: [MockModel].self, isAuthenticated: isAuthenticated, endpoint: endpoint, parameters: parameters)
        { (results: Result<[MockModel], NetworkError>?) in
            switch results
            {
            case .success(let result):
                //Assert
                print(result)
                print(mockModels)
                XCTAssertEqual(result, mockModels)
            case .failure(_):
                XCTFail("No model should be returned.")
            case .none:
                XCTFail("Results should never return in this case.")
            }
            //Fulfill expectations.
            expectation.fulfill()
        }
        
        //Wait for expectations to be fulfilled
        waitForExpectations(timeout: 5, handler: nil)
    }
}
