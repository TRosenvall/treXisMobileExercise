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
    var password: String? = nil
    var authenticationToken: String? = nil
    var isAuthenticated: Bool = false
    var accounts: [Account]? = []
    var transactions: [Transaction]? = []
}
