//
//  MockURLSession.swift
//  treXisMobileExerciseTests
//
//  Created by Timothy Rosenvall on 8/21/21.
//

import Foundation
@testable import treXisMobileExercise

class MockURLSession: URLSessionProtocol
{
    //MARK: - Constants and Variables
    var mockURLSessionDataTask = MockURLSessionDataTask() //How does one get an object without initializing it?
    var data: Data?
    var urlResponse: URLResponse?
    var error: Error?
    
    //Protocol Functions
    func dataTask(with request: URLRequest,
                           completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask //I don't really care about the URLSessionDataTask as long as the completionHandler on the function spits invokes.
    {
        completionHandler(data, urlResponse, error)
        return mockURLSessionDataTask //Return this mockURLSessionDataTask in order to prevent any actual network calls
    }
}
