//
//  NetworkRequests.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/20/21.
//

import Foundation

//Server has been setup on port 5555
private var baseURL = "http://localhost:"

class NetworkRequest: NetworkRequestProtocol
{
    //MARK: - Variables and Constants
    private var urlAndPort: String = baseURL
    var port: String = String()
    {
        didSet
        {
            urlAndPort = baseURL + port
        }
    }
    
    //MARK: - Protocol Functions
    func ping(completion: @escaping (Bool) -> Void)
    {
        //Build URL
        guard let url = URL(string: urlAndPort)
              else {return}
        
        //Build out server request
        var request = URLRequest(url: url)
            request.httpMethod = "HEAD"

        //Send Request to Server
        URLSession.shared.dataTask(with: request)
        { (_, response, error) -> Void in
            //Error Handling
            if let unwrappedError = error
            {
                print("Bad Port Number")
                print(unwrappedError.localizedDescription)
                completion(false)
                return
            }
            else
            {
                completion(true)
            }
        }.resume()
    }
    
    func login (parameters: [(String, Any)],
                completion: @escaping (Bool) -> Void)
    {
        //Login Endpoint String
        let endpoint: String = "/login"
        
        //Build URL
        guard let url = URL(string: urlAndPort + endpoint) else
        {
            print("Bad URL")
            completion(false);
            return
        }
        
        //Build out server request
        var request = URLRequest(url: url)
        var components = URLComponents()
        var queryItems = [URLQueryItem]()
        
        //Setup query items for server request
        for (key, value) in parameters
        {
            let queryItem = URLQueryItem(name: key, value: String(describing: value))
            queryItems.append(queryItem)
        }
        components.queryItems = queryItems

        //Encode the query items as data
        let queryItemsData = components.query?.data(using: .utf8)

        //Finalize request parameters
        request.httpMethod = "POST"
        request.httpBody = queryItemsData
        
        //Send request to server
        URLSession.shared.dataTask(with: request)
        { data, response, error in
            DispatchQueue.main.async
            {
                //Error Handling
                if let unwrappedError = error
                {
                    print("Transport Error")
                    print(unwrappedError.localizedDescription)
                    completion(false)
                    return
                }

                //Response Handling
                if let unwrappedResponse = response as? HTTPURLResponse
                {
                    let statusCode = unwrappedResponse.statusCode
                    if statusCode == 200 //Code Smell - Magic Number: 200 is the HTTPURLResponse code for a successful response.
                    {
                        print("Successfully logged in")
                        completion(true)
                    }
                    else
                    {
                        print("Server Error \(statusCode)")
                        print("Error 404: Wrong Username or Password.")
                        print("See here for other status code meanings:")
                        print("https://developer.mozilla.org/en-US/docs/Web/HTTP/Status")
                        completion(false)
                    }
                }
            }
        }.resume() //Tasks are initialized in suspended state, .resume() needed to start the task.
    }
    
    func getGenericModel<T>(endpoint: String,
                            parameters: [(String, Any)],
                            completion: @escaping (T?) -> Void) where T : Decodable, T : Equatable
    {
        //Build URL
        guard let url = URL(string: urlAndPort + endpoint)
              else
        {
            print("Bad URL")
            completion(nil)
            return
        }
        
        //Build out server request
        var request = URLRequest(url: url)
        guard let url = request.url
              else {completion(nil); return}
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        var queryItems = [URLQueryItem]()
        
        //Setup query items for server request
        for (key, value) in parameters
        {
            let queryItem = URLQueryItem(name: key, value: String(describing: value))
            queryItems.append(queryItem)
        }
        components?.queryItems = queryItems

        //Finalize request parameters
        request.httpMethod = "GET"
        request.url = components?.url
        
        //Send request to server
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async
            {
                //Error Handling
                if let unwrappedError = error
                {
                    print("Transport Error")
                    print(unwrappedError.localizedDescription)
                    completion(nil);
                    return
                }
                
                //Data Handling
                if let unwrappedData = data
                {
                    //JSON Parsing
                    do
                    {
                        let model = try JSONDecoder().decode(T.self, from: unwrappedData)
                        print("Successfully Decoded \(T.self) from JSON")
                        completion(model)
                    }
                    catch let jsonError
                    {
                        print("Error Decoding JSON")
                        print(jsonError.localizedDescription)
                        completion(nil);
                        return
                    }
                }
            }
        }.resume() //Tasks are initialized in suspended state, .resume() needed to start the task.
    }
}
