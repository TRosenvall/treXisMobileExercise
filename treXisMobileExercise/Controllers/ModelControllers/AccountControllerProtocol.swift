//
//  AccountControllerProtocol.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/21/21.
//

import Foundation

protocol AccountControllerProtocol
{
    //MARK: - Constants and Variables
    ///This is theinstance of `NetworkRequestProtocol` passed in from the `UserControllerProtocol` and is designed to hold
    ///its own port value. This `NetworkRequestProtocol` must be used to call any network functions or the port may not be
    ///set correctly and the network calls will fail.
    var networkRequestProtocol: NetworkRequestProtocol { get set }
    
    //MARK: - CRUD and Protocol Functions
    ///This function takes in the user's authentication status as a variable and invokes the completion handler with either
    ///the `[Account]` retrieved or the `NetworkError`. If the user is not authenticated, no network call will be placed.
    ///
    /// - Parameters:
    ///     - isAuthenticated: A bool defining the user's authentication status.
    ///     - completion: The completion handler is invoked to pass the account data back to the user, or any failure made inthe attempt.
    func getAccounts(isAuthenticated: Bool, completion: @escaping(Result<[Account], NetworkError>) -> Void)
    
    ///This function validates the `Account` model ID is not an empty string and contains only numbers.
    static func isValidID(account: Account) -> Bool
    
    ///This function validates the `Account` model Name is not an empty string.
    static func isValidName(account: Account) -> Bool
}
