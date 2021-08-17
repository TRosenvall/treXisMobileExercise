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
    
    //Helper Functions
    func isNegative(balance: Float) -> Bool {
        return balance < 0 ? true : false
    }
    
    //Helper Functions
    func formatBalance(balance: Float) -> String {
        return isNegative(balance: balance) ? "-$\(-balance)0" : "$\(balance)0"
    }
}
