//
//  Transactions.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/16/21.
//

import Foundation

struct Transaction: Equatable, Decodable
{
    let id: String
    let title: String
    let balance: Float
}
