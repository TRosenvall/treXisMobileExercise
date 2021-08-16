//
//  NetworkingResult.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/15/21.
//

import Foundation

enum NetworkingResult<T: Equatable, Error> {
    case success(T)
    case statusCode(Int)
    case failure(Error)
}

extension NetworkingResult: Equatable {
    static func == (lhs: NetworkingResult<T, Error>, rhs: NetworkingResult<T, Error>) -> Bool {
        switch(lhs, rhs) {
        case (success(let a), success(let b)) where a == b:
            return true
        case (statusCode(let a), statusCode(let b)) where a == b:
            return true
        default:
            return false
        }
    }
}
