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
    var networkRequest: NetworkRequestProtocol
    
    //MARK: - Lifecycle Functions
    init(networkRequest: NetworkRequestProtocol)
    {
        self.networkRequest = networkRequest
    }
    
    //MARK: - CRUD Functions
    func getAccounts(isAuthenticated: Bool, completion: @escaping(Result<[Account], NetworkError>) -> Void)
    {
        networkRequest.getGenericModel(isAuthenticated: isAuthenticated, endpoint: "/accounts", parameters: [])
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
}
