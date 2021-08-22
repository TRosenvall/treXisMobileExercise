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
    
    func testPing_withCorrectPort_willResultInSuccess() //This test will always fail because I'm struggling how to figure out how to get the properties passed into the MockURLSession while it's defined as a protocol. If it's a protocol, then I don't have access it it's instance members here, so I can't set them directly.
    {
        //Arrange
        let expectation = self.expectation(description: "Pinging Server")
        instanceUnderTest.port = self.defaultPort

        
        //Act
        instanceUnderTest.ping
        { results in
            switch results
            {
            case .success(let result):
                //Assert
                XCTAssertTrue(result)
            case .failure(_):
                XCTFail()
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testPing_withIncorrectURL_willResultWithError()
    {
        //Arrange
        instanceUnderTest.baseURLWithPort = "http://localhos:5555"
        
        //Act
        instanceUnderTest.ping
        { results in
            switch results
            {
            case .success(let result):
                //Assert
                XCTAssertTrue(result)
            case .failure(_):
                XCTFail()
            }
        }
    }
}

//func ping(completion: @escaping (Result<Bool, NetworkError>) -> Void)
//{
//    //Build URL
//    guard let url = URL(string: baseURLWithPort)
//          else {return}
//
//    //Build out server request
//    var request = URLRequest(url: url)
//        request.httpMethod = "HEAD"
//
//    //Send Request to Server
//    urlSession.dataTask(with: request)
//    { (_, response, error) -> Void in
//        //Error Handling
//        if let unwrappedError = error
//        {
//            print("Bad Port Number")
//            print(unwrappedError.localizedDescription)
//            self.port = defaultPort //Reset port to default
//            completion(.failure(.badPort))
//            return
//        }
//        else
//        {
//            print("Port Accepted")
//            completion(.success(true))
//        }
//    }.resume() //Tasks are initialized in suspended state, .resume() needed to start the task.
//}
