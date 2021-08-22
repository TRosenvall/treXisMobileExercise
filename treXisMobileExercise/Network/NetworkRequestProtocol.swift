//
//  NetworkRequestsProtocol.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/19/21.
//

import Foundation
protocol NetworkRequestProtocol
{
    //MARK: - Constants and Variables
    ///This is where the protocol should be passed in so that we can create mockDataTasks for unit testing. I'm having to
    ///pass in subclasses instead due to a struggle in conforming `URLSessionDataTask` to it's protocol and ahving the
    ///`URLSession.shared.dataTask` function work.
    var urlSessionProtocol: URLSessionProtocol { get set }
    
    //I probably should have made this a global variable so that nothing absolutely required the entire NetworkRequestProtocol. Then I could have made the NetworkRequestProtocol functions static and kept their calls confined to themselves. A potential refactor for the future.
    ///This variable is set with the initial value of 5555. The variable may be reset upon attempting to login. First,
    ///should the `portTextField` value not be empty, the port value will be updated on the instance of `NetworkRequest` within
    ///the active `UserController`. The userController will then attempt to ping the server before logging in. Should the ping
    ///fail, the port is reset to it's default value of 5555, otherwise the userController will attempt to login.
    var port: String { get set }
    
    //MARK: - Protocol Functions
    ///Attempts to ping the server and checks whether or not the server is able to be reached. If the server is reachable,
    ///the server completion handler returns true. The only way this function should fail is if the port is input incorrectly.
    ///
    /// - Parameters:
    ///     - port: A string defining the port at which the URL is available
    ///     - completion: The completion handler is invoked to pass the success state from pinging the server.
    func ping(completion: @escaping (Result<Bool,NetworkError>) -> Void)
    
    ///Takes in login parameters and sends a login request attempt to the server. Should the correct username and
    ///password be sent, should return an HTTPURLResponse status code of 200. If the request fails, the returned
    ///response status code should be 404. If the status code is 200, the function will return true, else it will
    ///return false
    ///
    /// - Parameters:
    ///     - parameters: An array of tuples where the first value is the username and the second value is the password
    ///     - completion: The completion handler to invoke to pass the success state of the login attempt to the application.
    func login(parameters: [(String, Any)],
               completion: @escaping(Result<Bool,NetworkError>) -> Void)
    
    ///Sends a GET request to the server to retrieve the data for the needed model. Should the model data be successfully
    ///retrieved, it will be parsed and decoded and then passed back to the modelController. Otherwise the function will
    ///complete with an error which can be used to notify the user of the issue.
    ///
    /// - Parameters:
    ///     - isAuthenticated: A boolean defining whether or not the current user is authenticated.
    ///     - endpoint: A string defining the endpoint of the URL at which the model can be found.
    ///     - parameters: An array of tupers in which the first value is a string, and the second value can be of any type. The array holds any necessary query parameters needed to retrieve the model.
    ///     - completion: The completion handler to invoke to pass the model or an error back to the modelController
    func getGenericModel<T: Decodable&Equatable> (isAuthenticated: Bool,
                                                  endpoint: String,
                                                  parameters: [(String, Any)],
                                                  completion: @escaping(Result<T,NetworkError>?) -> Void)
}
