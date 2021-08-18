//
//  MockNetworking.swift
//  treXisMobileExerciseTests
//
//  Created by Timothy Rosenvall on 8/18/21.
//

import Foundation
@testable import treXisMobileExercise

class MockNetworking: NetworkingProtocol {
    static func request<T>(endpoint: String, httpMethod: String, parameters: [(String, Any)], completion: @escaping (NetworkingResult<T, Error>?) -> Void) where T : Decodable, T : Equatable {
        <#code#>
    }
    
    static func login(parameters: [(String, Any)], completion: @escaping (Bool) -> Void) {
        <#code#>
    }
    
    static func getGenericModel<T>(endpoint: String, parameters: [(String, Any)], completion: @escaping (T?) -> Void) where T : Decodable, T : Equatable {
        <#code#>
    }
}
