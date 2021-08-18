//
//  NetworkingProtocol.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/18/21.
//

import Foundation

protocol NetworkingProtocol {
    static func request<T: Decodable> (endpoint: String, httpMethod: String, parameters: [(String, Any)], completion: @escaping(NetworkingResult<T, Error>?) -> Void)
    static func login( parameters: [(String, Any)], completion: @escaping(Bool) -> Void)
    static func getGenericModel<T: Decodable&Equatable> (endpoint: String, parameters: [(String, Any)], completion: @escaping(T?) -> Void)
}
