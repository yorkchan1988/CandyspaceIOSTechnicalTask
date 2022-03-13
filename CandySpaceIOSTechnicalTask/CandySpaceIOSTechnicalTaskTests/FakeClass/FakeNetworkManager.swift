//
//  FakeNetworkManager.swift
//  CandySpaceIOSTechnicalTaskTests
//
//  Created by YORK CHAN on 13/3/2022.
//

import Foundation
@testable import CandySpaceIOSTechnicalTask

class FakeNetworkManager: NetworkManagerProtocol {
    
    let searchResults = SearchResults(hits: [Hit(id: 1127174, previewURL: "https://cdn.pixabay.com/photo/2016/01/08/05/24/sunflower-1127174_150.jpg", largeImageURL: "https://pixabay.com/get/g3673d94165cea812de47afdf30bce7bc2286a22eb72c4a6cdd6f8977c301df9ea9b35328bcae4c6ea21f7eb4325a5f1e58945e019feb6d4f6b0d5cb27b07daab_1280.jpg")])
    
    func requestData<T: Codable>(apiPath: String, httpMethod: HTTPMethod, parameters: [String : String], responseType: T.Type, completionHandler: @escaping (Result<T, NetworkError>) -> ()) {
        
        completionHandler(.success(searchResults as! T))
    }
    
    func requestImage(urlString: String, completionHandler : @escaping (Result<Data, NetworkError>) -> ()) {
        
        completionHandler(.success(Data()))
    }
}
