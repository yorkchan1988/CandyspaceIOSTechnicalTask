//
//  FakeNetworkManager.swift
//  CandySpaceIOSTechnicalTaskTests
//
//  Created by YORK CHAN on 13/3/2022.
//

import Foundation
@testable import CandySpaceIOSTechnicalTask

class FakeNetworkManager: NetworkManagerProtocol {
    
    let searchResults = SearchResults(hits: [Hit(id: 1127174, previewURL: "https://cdn.pixabay.com/photo/2016/01/08/05/24/sunflower-1127174_150.jpg")])
    
    func requestData<T: Codable>(apiPath: String, httpMethod: HTTPMethod, parameters: [String : String], responseType: T.Type, completionHandler: @escaping (Result<T, NetworkError>) -> ()) {
        
        completionHandler(.success(searchResults as! T))
    }
    
    func requestImage(urlString: String, completionHandler : @escaping (Result<Data, NetworkError>) -> ()) {
        
        completionHandler(.success(Data()))
    }
}
