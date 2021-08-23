//
//  MockAccountController.swift
//  treXisMobileExerciseTests
//
//  Created by Timothy Rosenvall on 8/22/21.
//

import Foundation
@testable import treXisMobileExercise

class MockAccountController: AccountControllerProtocol
{
    //MARK: - Constants and Variables
    //This will not be used in the mock.
    var networkRequestProtocol: NetworkRequestProtocol = MockNetworkRequest()
    
    //MARK: - CRUD and Protocol Functions
    //Checks authentication, if true, completes with [Account], otherwise authentication error
    func getAccounts(isAuthenticated: Bool, completion: @escaping (Result<[Account], NetworkError>) -> Void) {
        if isAuthenticated
        {
            //Mock Account Data
            let account1 = Account(id: "1", name: "accountName1", balance: 0.00)
            let account2 = Account(id: "2", name: "accountName2", balance: 0.00)
            let account3 = Account(id: "3", name: "accountName3", balance: 0.00)
            let accounts = [account1, account2, account3]
            completion(.success(accounts))
        }
        else
        {
            completion(.failure(.authenticationError))
        }
    }
    
    //MARK: - Helper Functions
    //Validates the account information.
    static func isValidID(account: Account) -> Bool
    {
        return account.id.count > 0 && account.id.isNumeric
    }
    
    static func isValidName(account: Account) -> Bool
    {
        return account.name.count > 0
    }
}
