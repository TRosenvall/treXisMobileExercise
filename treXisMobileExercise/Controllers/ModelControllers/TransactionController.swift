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
    var networkRequestProtocol: NetworkRequestProtocol
    
    //MARK: - Lifecycle Functions
    init(networkRequestProtocol: NetworkRequestProtocol)
    {
        self.networkRequestProtocol = networkRequestProtocol
    }
    
    //MARK: - CRUD
    func getTransactions(isAuthenticated: Bool, accountID: String, completion: @escaping(Result<[Transaction], NetworkError>) -> Void)
    {
        networkRequestProtocol.getGenericModel(typeOf: [Transaction].self, isAuthenticated: isAuthenticated, endpoint: "/transactions", parameters: [("accountId", accountID)], completion:
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
    
    static func isValidID(transaction: Transaction) -> Bool
    {
        return transaction.id.count > 0 && transaction.id.isNumeric
    }
    
    static func isValidTitle(transaction: Transaction) -> Bool
    {
        return transaction.title.count > 0
    }
}
