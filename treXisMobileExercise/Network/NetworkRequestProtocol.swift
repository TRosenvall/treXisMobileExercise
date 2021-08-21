//
//  NetworkRequestsProtocol.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/19/21.
//

import Foundation
protocol NetworkRequestProtocol
{
    var port: String { get set }
    
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
