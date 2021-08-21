//
//  TransactionController.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/16/21.
//

import Foundation

class TransactionController: TransactionControllerProtocol
{
    //MARK: - Constants and Variables
    var networkRequest: NetworkRequestProtocol
    
    //MARK: - Lifecycle Functions
    init(networkRequest: NetworkRequestProtocol)
    {
        self.networkRequest = networkRequest
    }
    
    //MARK: - CRUD
    func getTransactions(isAuthenticated: Bool, accountID: String, completion: @escaping(Result<[Transaction], NetworkError>) -> Void)
    {
        networkRequest.getGenericModel(isAuthenticated: isAuthenticated, endpoint: "/transactions", parameters: [("accountId", accountID)], completion:
        { (results: Result<[Transaction], NetworkError>?) in
            guard let results = results
                  else {return}
            switch results
            {
            case .success(let transactions):
                completion(.success(transactions))
            case .failure(let networkError):
                completion(.failure(networkError))
            }
        })
    }
    
    //MARK: - Helper Functions
    static func isNegative(balance: Float) -> Bool
    {
        return balance < 0 ? true : false
    }

    static func formatBalance(balance: Float) -> String
    {
        return isNegative(balance: balance) ? "-$\(-balance)0" : "$\(balance)0"
    }
}
