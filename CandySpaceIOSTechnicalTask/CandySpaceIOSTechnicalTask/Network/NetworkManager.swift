//
//  APIManager.swift
//  CandySpaceIOSTechnicalTask
//
//  Created by YORK CHAN on 12/3/2022.
//

import Foundation

class NetworkManager {
    
    enum HTTPMethod: String {
        case GET = "GET"
        case POST = "POST"
    }
    
    private let timeoutIntervalForRequest = 30
    private let timeoutIntervalForResource = 30
    
    static let shared = NetworkManager(baseURLString: getBaseUrlString())

    private let baseURLString: String?
    private let session: URLSession

    private init(baseURLString: String?) {
        self.baseURLString = baseURLString
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(timeoutIntervalForRequest)
        configuration.timeoutIntervalForResource = TimeInterval(timeoutIntervalForResource)
        session = URLSession(configuration: configuration)
    }
    
    func requestData<T:Codable>(apiPath: String, httpMethod: HTTPMethod, parameters:[String:String], responseType: T.Type, completionHandler : @escaping (Result<Codable, NetworkError>) -> ()) {
            
        guard let baseURLString = baseURLString, let apiKey = getAPIKey(), var components = URLComponents(string: baseURLString+apiPath) else {
            completionHandler(.failure(NetworkError.clientError(apiPath)))
            return
        }
        
        if httpMethod == .GET {
            for (key, value) in parameters {
                components.queryItems = [
                    URLQueryItem(name: key, value: value)
                ]
            }
            components.queryItems?.append(URLQueryItem(name: "key", value: apiKey))
            components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        }
        
        guard let url = components.url else {
            completionHandler(.failure(NetworkError.clientError(apiPath)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
            
        if httpMethod == .POST {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            } catch {
                completionHandler(.failure(NetworkError.clientError(apiPath)))
            }
        }
        
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            
            guard let data = data else {
                completionHandler(.failure(NetworkError.serverError(apiPath)))
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completionHandler(.failure(NetworkError.serverError(apiPath)))
                return
            }
            
            guard let mime = response.mimeType, mime == "application/json" else {
                completionHandler(.failure(NetworkError.serverError(apiPath)))
                return
            }
            
            do {
                let object = try JSONDecoder().decode(responseType, from: data)
                completionHandler(.success(object))
            } catch {
                completionHandler(.failure(NetworkError.responseError(apiPath)))
            }
            
        }
        task.resume()
    }
}
