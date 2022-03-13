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
    
    func requestData(apiPath: String, httpMethod: HTTPMethod, parameters:[String:String], completionHandler : @escaping (Result<Data, NetworkError>) -> ()) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(searchResults) {
            completionHandler(.success(encoded))
        }
    }
    
    func requestImage(urlString: String, completionHandler : @escaping (Result<Data, NetworkError>) -> ()) {
        
        completionHandler(.success(Data()))
    }
}
