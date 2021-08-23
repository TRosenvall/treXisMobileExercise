//
//  MockNetworkRequest.swift
//  treXisMobileExerciseTests
//
//  Created by Timothy Rosenvall on 8/22/21.
//

import Foundation
@testable import treXisMobileExercise

class MockNetworkRequest: NetworkRequestProtocol
{
    //MARK: Constants and Variables
    //Build mockModels for data
    var urlSessionProtocol: URLSessionProtocol = MockURLSession()
    
    //This will not be used here, needs to be part of protocol?
    var port: String = ""
    
    //Protocol Functions
    //Return success with ping if port is a numeric string.
    func ping(completion: @escaping (Result<Bool, NetworkError>) -> Void)
    {
        completion(.success(port.isNumeric))
    }
    
    //Return success if parameters contain two tupels with the strings username and password as the first values.
    func login(parameters: [(String, Any)], completion: @escaping (Result<Bool, NetworkError>) -> Void)
    {
        if parameters[0].0 == "username" && parameters[1].0 == "password"
        {
            completion(.success( true ))
        }
        else
        {
            completion(.failure(.badUsernameOrPassword))
        }
    }
    
    //Pull the model data we encoded in the initializer, run a mockURLSession.dataTask and decode that same model data. Pass it back with generic parameter T.
    func getGenericModel<T>(typeOf: T.Type, isAuthenticated: Bool, endpoint: String, parameters: [(String, Any)], completion: @escaping (Result<T, NetworkError>?) -> Void) where T : Decodable, T : Equatable
    {
        //Check Authentication
        if isAuthenticated
        {
            //Check Type Of Generic T
            if typeOf == [Account].self
            {
                //Mock Account Data
                let account1 = Account(id: "1", name: "accountName1", balance: 0.00)
                let account2 = Account(id: "2", name: "accountName2", balance: 0.00)
                let account3 = Account(id: "3", name: "accountName3", balance: 0.00)
                let accounts = [account1, account2, account3]
                completion(.success(accounts as! T))
            }
            else if typeOf == [Transaction].self
            {
                //Mock Transaction Data
                let transaction1 = Transaction(id: "1", title: "transactionName1", balance: 0.00)
                let transaction2 = Transaction(id: "2", title: "transactionName2", balance: 0.00)
                let transaction3 = Transaction(id: "3", title: "transactionName3", balance: 0.00)
                let transactions = [transaction1, transaction2, transaction3]
                completion(.success(transactions as! T))
            }
            else
            {
                completion(.failure(.badData))
            }
        }
        else
        {
            completion(.failure(.authenticationError))
        }
    }
}
