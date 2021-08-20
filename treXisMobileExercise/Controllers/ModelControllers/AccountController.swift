//
//  AccountController.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/16/21.
//

import Foundation

class AccountController {
    
    //MARK: - Constants and Variables
    let networkRequest: NetworkRequestProtocol
    
    //Source of Truth
    var accounts: [Account] = []
    
    //MARK: - Lifecycle Functions
    init(networkRequest: NetworkRequestProtocol)
    {
        self.networkRequest = networkRequest
    }
    
    //MARK: - CRUD Functions
    func getAccounts(completion: @escaping(Bool) -> Void) {
        networkRequest.getGenericModel(endpoint: "/accounts", parameters: []) { (accounts: [Account]?) in
            guard let accounts = accounts else {return}
            self.accounts = accounts
            completion(true)
        }
    }
    
    //MARK: - Helper Functions
    func isNegative(balance: Float) -> Bool {
        return balance < 0 ? true : false
    }
    
    func formatBalance(balance: Float) -> String {
        return isNegative(balance: balance) ? "-$\(-balance)" : "$\(balance)"
    }
}
