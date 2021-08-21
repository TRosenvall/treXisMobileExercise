//
//  NetworkRequests.swift
//  treXisMobileExercise
//
//  Created by Timothy Rosenvall on 8/20/21.
//

import Foundation

//Server has been setup on port 5555
private let baseURL = "http://localhost:"
private let defaultPort = "5555"

class NetworkRequest: NetworkRequestProtocol
{
    //MARK: - Variables and Constants
    private var baseURLWithPort: String = baseURL + defaultPort
    
    //This variable is set in the LoginViewController when the login button is tapped. It is also reset to the default port should a bad port be tried in the ping() function below.
    var port: String = defaultPort
    {
        didSet
        {
            //This is the string that will be passed into all of the networking functions for the URL
            baseURLWithPort = baseURL + port
        }
    }
    
    //MARK: - Protocol Functions
    func ping(completion: @escaping (Result<Bool, NetworkError>) -> Void)
    {
        //Build URL
        guard let url = URL(string: baseURLWithPort)
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
                self.port = defaultPort //Reset port to default
                completion(.failure(.badPort))
                return
            }
            else
            {
                print("Port Accepted")
                completion(.success(true))
            }
        }.resume() //Tasks are initialized in suspended state, .resume() needed to start the task.
    }
    
    func login (parameters: [(String, Any)],
                completion: @escaping (Result<Bool, NetworkError>) -> Void)
    {
        //Login Endpoint String
        let endpoint: String = "/login"
        
        //Build URL
        guard let url = URL(string: baseURLWithPort + endpoint) else
        {
            print("Bad URL")
            completion(.failure(.badURL));
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
                    completion(.failure(.transportError))
                    return
                }

                //Response Handling
                if let unwrappedResponse = response as? HTTPURLResponse
                {
                    let statusCode = unwrappedResponse.statusCode
                    if statusCode == 200 //Code Smell - Magic Number: 200 is the HTTPURLResponse code for a successful response.
                    {
                        print("Account Authenticated")
                        print("Successfully logged in")
                        completion(.success(true))
                    }
                    else
                    {
                        print("Server Error \(statusCode)")
                        print("Error 404 is thown when the user inputs the wrong username or password.")
                        print("But this may occur for other reasons as well.")
                        print("See here for other status code meanings:")
                        print("https://developer.mozilla.org/en-US/docs/Web/HTTP/Status")
                        if statusCode == 404 //This may not be the only way to get this error, but for now, passing in the wrong username or password appears to be the only way to get it.
                        {
                            completion(.failure(.badUsernameOrPassword))
                        }
                        else
                        {
                            completion(.failure(.serverError(statusCode)))
                        }
                    }
                }
            }
        }.resume() //Tasks are initialized in suspended state, .resume() needed to start the task.
    }
    
    ///Ordinarily, I'd attempt to receive an authentication token and then make that apart of my API calls. However in this case,
    ///no authentication token is received from the server. Because of this, I'm just using the isAuthenticated bool to verify whether
    ///or not any further network calls need to be made. That is to say, in the getGenericModel() function, I check whether or not
    ///isAuthenticated is true before doing anything network related.
    func getGenericModel<T>(isAuthenticated: Bool,
                            endpoint: String,
                            parameters: [(String, Any)],
                            completion: @escaping (Result<T, NetworkError>?) -> Void) where T : Decodable, T : Equatable
    {
        if isAuthenticated {
            //Build URL
            guard let url = URL(string: baseURLWithPort + endpoint)
            else
            {
                print("Bad URL")
                completion(.failure(.badURL))
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
            URLSession.shared.dataTask(with: request)
            { data, response, error in
                DispatchQueue.main.async
                {
                    //Error Handling
                    if let unwrappedError = error
                    {
                        print("Transport Error")
                        print(unwrappedError.localizedDescription)
                        completion(.failure(.transportError));
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
                            completion(Result.success(model))
                        }
                        catch let jsonError
                        {
                            print("Error Decoding JSON")
                            print(jsonError.localizedDescription)
                            completion(.failure(.badData));
                            return
                        }
                    }
                }
            }.resume() //Tasks are initialized in suspended state, .resume() needed to start the task.
        }
        else
        {
            print("Error Recieving Account Data: User Is Not Authenticated")
            completion(.failure(.authenticationError))
        }
    }
}
