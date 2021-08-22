//
//  Balance.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/21/21.
//

import Foundation

class Balance
{
    static func isNegative(balance: Float) -> Bool
    {
        return balance < 0 ? true : false
    }

    static func format(balance: Float) -> String
    {
        return isNegative(balance: balance) ? "-$\(-balance)0" : "$\(balance)0"
    }
}
