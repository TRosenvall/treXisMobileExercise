//
//  String.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/21/21.
//
//  This code was taken from https://stackoverflow.com/questions/34587094/how-to-check-if-text-contains-only-numbers/34587234

import Foundation

extension String {
    //Check that the string contains only numbers.
    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
}
