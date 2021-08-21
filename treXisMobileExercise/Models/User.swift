//
//  User.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/20/21.
//

import Foundation

//No Authentication Token will ever be received from server for API calls.
struct User
{
    var username: String? = nil
    var password: String? = nil //This value wouldn't normally be tracked, particularly as a plaintext value. In this case, I simply left if here for the sake of completion.
    var authenticationToken: String? = nil
    var isAuthenticated: Bool = false
    var accounts: [Account]? = []
    var transactions: [Transaction]? = []
}
