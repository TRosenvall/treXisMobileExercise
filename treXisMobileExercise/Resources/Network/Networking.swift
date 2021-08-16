//
//  Networking.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/15/21.
//

import Foundation

private let baseURL = "http://localhost:5555"
class Networking {
    
    static func request<T: Decodable> (endpoint: String, httpMethod: String, parameters: [(String, Any)], completion: @escaping(NetworkingResult<T, Error>) -> Void) {
        //Build URL
        guard let url = URL(string: baseURL + endpoint) else {
            completion(.failure(NetworkingError.badURL))
            return
        }
        //Build out server request
        var request = URLRequest(url: url)
        var components = URLComponents()
        var queryItems = [URLQueryItem]()
        
            //Setup query items for server request
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: String(describing: value))
            queryItems.append(queryItem)
        }
        
        components.queryItems = queryItems

        let queryItemsData = components.query?.data(using: .utf8)

        request.httpBody = queryItemsData
        request.httpMethod = httpMethod
        
        //Send request to server
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async { //This URLSession seems to respond with a 404 error more often than anything else. I can't seem to resolve the issue through the code here and I wonder if I have the server setup incorrectly on my machine. Should the response be a 404 error, pressing the login button a... few more times... seems make it go through.
                if let unwrappedError = error {
                    completion(.failure(unwrappedError))
                    return
                }

                if let unwrappedData = data, endpoint != "/login" { //I don't like that I had to hard code in that it should only try running the JSONDecoder if it wasn't a login request, but the server shows that it will only return a statusCode for any login attempts. Seems like there should be a more elegant way of doing this.
                    do {
                        let obj = try JSONDecoder().decode(T.self, from: unwrappedData)
                        completion(.success(obj))
                    } catch {
                        completion(.failure(error))
                    }
                }

                if let unwrappedResponse = response as? HTTPURLResponse {
                    completion(.statusCode(unwrappedResponse.statusCode))
                } else {
                    completion(.failure(NetworkingError.badResponse))
                    return
                }
            }
        }.resume()
    }
}
