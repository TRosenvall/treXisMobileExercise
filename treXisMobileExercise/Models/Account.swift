//
//  Account.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/16/21.
//

import Foundation

struct Account: Equatable, Decodable
{
    let id: String
    let name: String
    let balance: Float //Can be any value.
}
