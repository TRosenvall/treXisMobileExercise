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
    var networkRequest: NetworkRequestProtocol { get set }
    
    //MARK: - CRUD Functions
    func getAccounts(isAuthenticated: Bool, completion: @escaping(Result<[Account], NetworkError>) -> Void)

    //MARK: - Helper Functions
    static func isNegative(balance: Float) -> Bool
    
    static func formatBalance(balance: Float) -> String
}
