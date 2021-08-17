//
//  TransactionController.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/16/21.
//

import Foundation

class TransactionController {
    
    //Singleton
    static let shared = TransactionController()
    
    //Source of Truth
    var transactions: [Transaction] = []
    
    //CRUD
    func getTransactions(accountID: String, completion: @escaping(Bool) -> Void) {
        Networking.shared.getGenericModel(endpoint: "/transactions", parameters: [("accountId",accountID)]) { (transactions: [Transaction]?) in
            guard let transactions = transactions else {return}
            self.transactions = transactions
            completion(true)
        }
    }
}
