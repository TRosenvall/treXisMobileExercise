//
//  UserControllerProtocol.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/21/21.
//

import Foundation

protocol UserControllerProtocol
{
    //MARK: - Constants and Variables
    ///This instance of `NetworkRequestProtocol` is designed to hold its own port value. This value will be used to call
    ///any `NetworkRequestProtocol` functions which are all called from the from the active instance of `UserControllerProtocol`
    var networkRequestProtocol: NetworkRequestProtocol { get set }
    
    ///Because the `User` model tracks it's own `[Account]` and `[Transaction]`, it is prudent that the `UserController` be able
    ///to call the modelControllers directly to retreive and interact with these models.
    var accountControllerProtocol: AccountControllerProtocol { get set }
    var transactionControllerProtocol: TransactionControllerProtocol { get set }
    
    //Source of Truth
    ///This is the model which is called to define any property related to the current user. Should there be any required
    ///information related to the user themselves which need to be displayed to the user on a viewController, this is where
    ///that information will be found.
    var user: User { get set }
    
    //MARK: - CRUD and Protocol Functions
    ///This function simply takes the passed in values for the username and password and is to populate the user model with
    ///them when the login button is tapped.
    ///
    /// - Parameters:
    ///     - username: A string defining the user's login username.
    ///     - password: A string defining the user's password credential.
    func setUsernameAndPassword(username: String, password: String)
    
    ///This function takes in a port number, the user's username and password as parameters, and completes by authenticating
    ///the user and logging into the server or passing back a `NetworkError`.
    ///
    /// - Parameters:
    ///     - port: A string defining the servers port number.
    ///     - parameters: An array of tuples in which the username and password are passed to be sent as query items to
    ///     the server.
    ///     - completion: The completion handler is invoked to pass the success state from authenticating the user.
    func authenticateAndLogin(port: String, parameters: [(String, Any)], completion: @escaping(Result<Void, NetworkError>) -> Void)
    
    ///This function is called to retreive the `[Account]` to be set for the user. If it is unable to retrieve and decode the
    ///data, it will pass back a `NetworkError`.
    ///
    /// - Parameters:
    ///     - completion: The completion handler is invoked to pass the success state from retrieving the user's accounts data.
    func retrieveAccounts(completion: @escaping (Result<Void, NetworkError>) -> Void)
    
    ///This function takes in the accountID as a string and is called to retreive all the `[Transaction]` on the given account,
    ///which will be set for the user. If the function is called again, it will replace the users transactions with a new copy.
    ///If it is unable to retrieve and decode the data, it will pass back a `NetworkError`.
    ///
    /// - Parameters:
    ///     - accountID: A string defining which account for which the server should be attempting to retreive the transacactions.
    ///     - completion: The completion handler is invoked to pass the success state from retrieving the user's accounts data.
    func retrieveAccountTransactions(accountID: String, completion: @escaping (Result<Void, NetworkError>) -> Void)
}
