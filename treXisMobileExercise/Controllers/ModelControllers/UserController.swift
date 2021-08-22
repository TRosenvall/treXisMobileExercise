//
//  UserController.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/20/21.
//

import Foundation

class UserController: UserControllerProtocol
{
    //MARK: - Constants and Variables
    var urlSessionProtocol = URLSession.shared
    var networkRequest: NetworkRequestProtocol //This networkRequestProtocol is singular and passed through every other controller as needed. It should not be declared again.
    var accountControllerProtocol: AccountControllerProtocol
    var transactionControllerProtocol: TransactionControllerProtocol
    
    //Source of Truth
    var user: User = User()
    
    //MARK: - Lifecycle Functions
    init()
    {
        self.networkRequest = NetworkRequest(urlSessionProtocol: self.urlSessionProtocol)
        self.accountControllerProtocol = AccountController(networkRequest: self.networkRequest)
        self.transactionControllerProtocol = TransactionController(networkRequest: self.networkRequest)
    }
    
    //MARK: - CRUD and Protocol Functions
    func setUsernameAndPassword(username: String, password: String)
    {
        user.username = username
        user.password = password
    }
    
    func authenticateAndLogin(port: String, parameters: [(String, Any)], completion: @escaping(Result<Void, NetworkError>) -> Void)
    {
        //Set the port value
        if port != ""
        {
            networkRequest.port = port
        }
        //Attempt to ping the server at the given port
        networkRequest.ping
        { results in
            switch results
            {
            //If the server was successfully pinged
            case .success(_):
                //Attempt to log into the server
                self.networkRequest.login(parameters: parameters)
                { results in
                    switch results
                    {
                    case .success(let successfullyLoggedIn):
                        //Complete by setting the users authentication status
                        self.user.isAuthenticated = successfullyLoggedIn
                        completion(.success(()))
                    case .failure(let networkError):
                        completion(.failure(networkError))
                    }
                }
            case .failure(let networkError):
                print("Could not reach server at \(port)")
                completion(.failure(networkError))
            }
        }
    }
    
    func retrieveAccounts(completion: @escaping (Result<Void, NetworkError>) -> Void)
    {
        accountControllerProtocol.getAccounts(isAuthenticated: user.isAuthenticated)
        { results in
            switch results
            {
            //If success, populate user accounts variable
            case .success(let accounts):
                self.user.accounts = accounts
                completion(.success(()))
            case .failure(let networkError):
                completion(.failure(networkError))
            }
        }
    }
    
    func retrieveAccountTransactions(accountID: String, completion: @escaping (Result<Void, NetworkError>) -> Void)
    {
        transactionControllerProtocol.getTransactions(isAuthenticated: user.isAuthenticated, accountID: accountID)
        { results in
            switch results
            {
            //If success, populate user accounts variable
            case .success(let transactions):
                self.user.transactions = transactions
                completion(.success(()))
            case .failure(let networkError):
                completion(.failure(networkError))
            }
        }
    }
}
