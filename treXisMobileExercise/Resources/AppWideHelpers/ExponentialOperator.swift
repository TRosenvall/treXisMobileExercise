//
//  ExponentialOperator.swift
//  AttemptOne
//
//  Created by Timothy Rosenvall on 8/13/21.
//
//  This code was taken from https://forums.swift.org/t/exponents-in-swift/18337/8

import Foundation

precedencegroup Exponentiative {
  associativity: left
  higherThan: MultiplicationPrecedence
}

infix operator ** : Exponentiative

public func ** <N: BinaryInteger>(base: N, power: N) -> N {
    return N.self( pow(Double(base), Double(power)) )
}

public func ** <N: BinaryFloatingPoint>(base: N, power: N) -> N {
    return N.self ( pow(Double(base), Double(power)) )
}

precedencegroup ExponentiativeAssignment {
  associativity: right
  higherThan: MultiplicationPrecedence
}

infix operator **= : ExponentiativeAssignment

public func **= <N: BinaryInteger>(lhs: inout N, rhs: N) {
    lhs = lhs ** rhs
}

public func **= <N: BinaryFloatingPoint>(lhs: inout N, rhs: N) {
    lhs = lhs ** rhs
}
