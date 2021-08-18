//
//  AccountController.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/16/21.
//

import Foundation

class AccountController {
    
    //Singleton
    static let shared = AccountController()
    
    //Source of Truth
    var accounts: [Account] = []
    
    //CRUD Functions
    func getAccounts(completion: @escaping(Bool) -> Void) {
        Networking.getGenericModel(endpoint: "/accounts", parameters: []) { (accounts: [Account]?) in
            guard let accounts = accounts else {return}
            self.accounts = accounts
            completion(true)
        }
    }
    
    func isNegative(balance: Float) -> Bool {
        return balance < 0 ? true : false
    }
    
    //Helper Functions
    func formatBalance(balance: Float) -> String {
        return isNegative(balance: balance) ? "-$\(-balance)" : "$\(balance)"
    }
}
