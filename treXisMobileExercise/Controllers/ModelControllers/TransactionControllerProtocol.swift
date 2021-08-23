//
//  TransactionControllerProtocol.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/21/21.
//

import Foundation

protocol TransactionControllerProtocol
{
    //MARK: - Constants and Variables
    ///This is theinstance of `NetworkRequestProtocol` passed in from the `UserControllerProtocol` and is designed to hold
    ///its own port value. This `NetworkRequestProtocol` must be used to call any network functions or the port may not be
    ///set correctly and the network calls will fail.
    var networkRequestProtocol: NetworkRequestProtocol { get set }
    
    //MARK: - CRUD and Protocol Functions
    ///This function takes in the user's authentication status as a variable and invokes the completion handler with either
    ///the `[Transaction]` retrieved or the `NetworkError`. If the user is not authenticated, no network call will be placed.
    ///
    /// - Parameters:
    ///     - isAuthenticated: A bool defining the user's authentication status.
    ///     - completion: The completion handler is invoked to pass an account's transaction data back to the user, or any failure made inthe attempt.
    func getTransactions(isAuthenticated: Bool, accountID: String, completion: @escaping(Result<[Transaction], NetworkError>) -> Void)
    
    ///This function validates the `Transaction` model `ID` is not an empty string and contains only numbers.
    static func isValidID(transaction: Transaction) -> Bool
    
    ///This function validates the `Transaction` model `Title` is not an empty string.
    static func isValidTitle(transaction: Transaction) -> Bool
}
