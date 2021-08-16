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
        Networking.shared.getGenericModel(endpoint: "/accounts", parameters: []) { (accounts: [Account]?) in
            guard let accounts = accounts else {return}
            self.accounts = accounts
            completion(true)
        }
    }
}
