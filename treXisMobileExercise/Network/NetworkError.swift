//
//  NetworkError.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/20/21.
//

import UIKit

enum NetworkError: Error
{
    case badPort
    case badURL
    case badUsernameOrPassword
    case authenticationError
    case transportError
    case serverError(Int)
    case badData
    
    var description: String
    {
        get
        {
            switch self
            {
            case .badPort:
                return "Unable to access server through port."
            case .badURL:
                return "Unable to access server at the given URL"
            case .badUsernameOrPassword:
                return "Incorrect Username or Password"
            case .authenticationError:
                return "User not authenticated"
            case .transportError:
                return "Unable to reach server"
            case .serverError(let statusCode):
                return "Server Error \(statusCode)"
            case .badData:
                return "Unable to parse received data"
            }
        }
    }
}
