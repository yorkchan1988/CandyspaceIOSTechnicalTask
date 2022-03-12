//
//  APIManager.swift
//  CandySpaceIOSTechnicalTask
//
//  Created by YORK CHAN on 12/3/2022.
//

import Foundation

class NetworkManager {
    
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
    
    func requestData(apiPath: String, httpMethod: String, parameters:[String:String], completionHandler : @escaping (Result<Any, NetworkError>) -> ()) {
            
        guard let baseURLString = baseURLString, let url = URL(string: baseURLString+apiPath) else {
            completionHandler(.failure(NetworkError.serverError(apiPath)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
            
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch {
            completionHandler(.failure(NetworkError.clientError(apiPath)))
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
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                completionHandler(.success(json))
            } catch {
                completionHandler(.failure(NetworkError.responseError(apiPath)))
            }
            
        }
        task.resume()
    }
}
