//
//  MockTransactionController.swift
//  treXisMobileExerciseTests
//
//  Created by Timothy Rosenvall on 8/22/21.
//

import Foundation
@testable import treXisMobileExercise

class MockTransactionController: TransactionControllerProtocol
{
    //MARK: - Constants and Variables
    //This will not be used in the mock.
    var networkRequestProtocol: NetworkRequestProtocol = MockNetworkRequest()
    
    //MARK: - CRUD and Protocol Functions
    //Checks authentication, if true, completes with [Account], otherwise authentication error
    func getTransactions(isAuthenticated: Bool, accountID: String, completion: @escaping (Result<[Transaction], NetworkError>) -> Void)
    {
        if isAuthenticated
        {
            //Mock Transaction Data
            let transaction1 = Transaction(id: "1", title: "transactionName1", balance: 0.00)
            let transaction2 = Transaction(id: "2", title: "transactionName2", balance: 0.00)
            let transaction3 = Transaction(id: "3", title: "transactionName3", balance: 0.00)
            let transactions = [transaction1, transaction2, transaction3]
            completion(.success(transactions))
        }
        else
        {
            completion(.failure(.authenticationError))
        }
    }
    
    //MARK: - Helper Functions
    //Validates the account information.
    static func isValidID(transaction: Transaction) -> Bool
    {
        return transaction.id.count > 0 && transaction.id.isNumeric
    }
    
    static func isValidTitle(transaction: Transaction) -> Bool
    {
        return transaction.title.count > 0
    }
}
