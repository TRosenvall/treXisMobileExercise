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
    var networkRequest: NetworkRequestProtocol { get set }
    var accountControllerProtocol: AccountControllerProtocol { get set }
    var transactionControllerProtocol: TransactionControllerProtocol { get set }
    
    //Source of Truth
    var user: User { get set }
    
    //MARK: - CRUD and Helper Functions
    func setUsernameAndPassword(username: String, password: String)
    func authenticateAndLogin(port: String, parameters: [(String, Any)], completion: @escaping(Result<Void, NetworkError>) -> Void)
    func retrieveAccounts(completion: @escaping (Result<Void, NetworkError>) -> Void)
    func retrieveAccountTransactions(accountID: String, completion: @escaping (Result<Void, NetworkError>) -> Void)
}
