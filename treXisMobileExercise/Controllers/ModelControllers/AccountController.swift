//
//  AccountController.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/16/21.
//

import Foundation

class AccountController: AccountControllerProtocol
{
    //MARK: - Constants and Variables
    var networkRequestProtocol: NetworkRequestProtocol
    
    //MARK: - Lifecycle Functions
    init(networkRequestProtocol: NetworkRequestProtocol)
    {
        self.networkRequestProtocol = networkRequestProtocol
    }
    
    //MARK: - CRUD Functions
    func getAccounts(isAuthenticated: Bool, completion: @escaping(Result<[Account], NetworkError>) -> Void)
    {
        networkRequestProtocol.getGenericModel(typeOf: [Account].self, isAuthenticated: isAuthenticated, endpoint: "/accounts", parameters: [])
        { (results: Result<[Account], NetworkError>?) in
            guard let results = results
                  else {return}
            switch results
            {
            case .success(let accounts):
                completion(.success(accounts))
            case .failure(let networkError):
                completion(.failure(networkError))
            }
        }
    }
    
    static func isValidID(account: Account) -> Bool
    {
        return account.id.count > 0 && account.id.isNumeric
    }
    
    static func isValidName(account: Account) -> Bool
    {
        return account.name.count > 0
    }
}
