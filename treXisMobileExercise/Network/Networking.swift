//
//  Networking.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/15/21.
//

import Foundation

private let baseURL = "http://localhost:5555"
class Networking {
    
    static func request<T: Decodable> (endpoint: String, httpMethod: String, parameters: [(String, Any)], completion: @escaping(NetworkingResult<T, Error>?) -> Void) {
        //Build URL
        guard let url = URL(string: baseURL + endpoint) else {
            print("Bad URL")
            completion(.failure(NetworkingError.badURL))
            return
        }
        
        //Build out server request
        var request = URLRequest(url: url)
        guard let url = request.url else {completion(nil); return}
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        var queryItems = [URLQueryItem]()
        
            //Setup query items for server request
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: String(describing: value))
            queryItems.append(queryItem)
        }
        
        components?.queryItems = queryItems

        let queryItemsData = components?.query?.data(using: .utf8)

        request.httpMethod = httpMethod
        if httpMethod == "POST" { //I don't like that this is hardcoded either, but I'm still learning about httpMethod. Apparently the GET method doesn't allow a body, but it appears to be required to login which is done as a POST method.
            request.httpBody = queryItemsData
        } else {
            request.url = components?.url
        }
        
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
                    } catch let jsonError {
                        print(jsonError)
                        completion(.failure(jsonError))
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
    
    static func login( parameters: [(String, Any)], completion: @escaping(Bool) -> Void) {
        request(endpoint: "/login", httpMethod: "POST", parameters: parameters) { (result: NetworkingResult<Int, Error>?) in //This will either result in an error or perform a push to the dashboardViewController, in which case the type of the result is unimportant and Int was used as a placeholder.
            
            guard let result = result else {return}
            if result == NetworkingResult.statusCode(200) {
                //If login was successful, pull accounts from server
                AccountController.shared.getAccounts { successfullyRetreivedAccounts in
                    if successfullyRetreivedAccounts {
                        completion(true)
                    }
                }
            } else {
                print("Incorrect Username or Password")
                completion(false)
            }
        }
    }
    
    static func getGenericModel<T: Decodable&Equatable> (endpoint: String, parameters: [(String, Any)], completion: @escaping(T?) -> Void) {
        Networking.request(endpoint: endpoint, httpMethod: "GET", parameters: parameters) { (results: NetworkingResult<T, Error>?) in
            //Put the account info into the accountController Source of Truth
            if let results = results,
               case .success(let result) = results {
                completion(result)
            } else if let results = results,
                      case .failure(let error) = results {
                print("Error retreiving model from server")
                print(error)
                completion(nil)
            } else {
                completion(nil)
            }
        }
    }
}
