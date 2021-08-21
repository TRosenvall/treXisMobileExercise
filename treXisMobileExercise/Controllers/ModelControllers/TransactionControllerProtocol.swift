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
    var networkRequest: NetworkRequestProtocol { get set }
    
    //MARK: - CRUD
    func getTransactions(isAuthenticated: Bool, accountID: String, completion: @escaping(Result<[Transaction], NetworkError>) -> Void)
    
    //MARK: - Helper Functions
    static func isNegative(balance: Float) -> Bool

    static func formatBalance(balance: Float) -> String
}
