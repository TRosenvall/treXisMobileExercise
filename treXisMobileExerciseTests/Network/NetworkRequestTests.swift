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
    
    func testGetGenericModelForAccountModel_passInIsAuthenticatedFalse_willReceiveNetworkErrorAuthenticationError()
    {
        //Arrange
        //Asyncronous Expectation Set
        let expectation = self.expectation(description: "Pinging Server")
        //Reset the baseURLWithPort to the default port
        instanceUnderTest.port = self.defaultPort
        //Set correct parameters
        let isAuthenticated = false
        //No network call made if not authenticated
        let endpoint = "/accounts"
        let parameters: [(String, Any)] = []
        
        //Act
        //Function to be tested
        instanceUnderTest.getGenericModel(isAuthenticated: isAuthenticated, endpoint: endpoint, parameters: parameters)
        { (results: Result<[Account], NetworkError>?) in
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
    
    func testGetGenericModelForAccountModel_passInBadEndpoint_willReceiveNetworkErrorBadURL()
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
        let urlSession = MockURLSession(data: nil, urlResponse: nil, error: NetworkError.badData)
        instanceUnderTest.urlSessionProtocol = urlSession
        
        //Act
        //Function to be tested
        instanceUnderTest.getGenericModel(isAuthenticated: isAuthenticated, endpoint: endpoint, parameters: parameters)
        { (results: Result<[Account], NetworkError>?) in
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
}

//func getGenericModel<T>(isAuthenticated: Bool,
//                        endpoint: String,
//                        parameters: [(String, Any)],
//                        completion: @escaping (Result<T, NetworkError>?) -> Void) where T : Decodable, T : Equatable
//{
//    if isAuthenticated {
//        //Build URL
//        guard let url = URL(string: baseURLWithPort + endpoint)
//        else
//        {
//            print("Bad URL")
//            completion(.failure(.badURL))
//            return
//        }
//
//        //Build out server request
//        var request = URLRequest(url: url)
//        guard let url = request.url
//              else {completion(nil); return}
//        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
//        var queryItems = [URLQueryItem]()
//
//        //Setup query items for server request
//        for (key, value) in parameters
//        {
//            let queryItem = URLQueryItem(name: key, value: String(describing: value))
//            queryItems.append(queryItem)
//        }
//        components?.queryItems = queryItems
//
//        //Finalize request parameters
//        request.httpMethod = "GET"
//        request.url = components?.url
//
//        //Send request to server
//        urlSessionProtocol.dataTask(with: request)
//        { data, response, error in
//            DispatchQueue.main.async
//            {
//                //Error Handling
//                if let unwrappedError = error
//                {
//                    print("Transport Error")
//                    print(unwrappedError.localizedDescription)
//                    completion(.failure(.transportError));
//                    return
//                }
//
//                //Data Handling
//                if let unwrappedData = data
//                {
//                    //JSON Parsing
//                    do
//                    {
//                        let model = try JSONDecoder().decode(T.self, from: unwrappedData)
//                        print("Successfully Decoded \(T.self) from JSON")
//                        completion(Result.success(model))
//                    }
//                    catch let jsonError
//                    {
//                        print("Error Decoding JSON")
//                        print(jsonError.localizedDescription)
//                        completion(.failure(.badData));
//                        return
//                    }
//                }
//            }
//        }.resume() //Tasks are initialized in suspended state, .resume() needed to start the task.
//    }
//    else
//    {
//        print("Error Recieving Account Data: User Is Not Authenticated")
//        completion(.failure(.authenticationError))
//    }
//}

