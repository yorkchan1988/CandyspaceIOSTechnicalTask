//
//  SearchAPIOperation.swift
//  CandySpaceIOSTechnicalTask
//
//  Created by YORK CHAN on 12/3/2022.
//

import Foundation

class SearchAPIOperation: NetworkOperation {
    private let apiPath: String = ""
    private let networkManager: NetworkManager
    private let searchText: String
    
    init(searchText: String, networkManager: NetworkManager = NetworkManager.shared) {
        self.searchText = searchText.replacingOccurrences(of: " ", with: "+")
        self.networkManager = networkManager
    }
       
    override func main() {
        
        let parameters = [
            "q":searchText,
            "image_type":"photo"
        ]
        
        networkManager.requestData(apiPath: apiPath, httpMethod: .GET, parameters: parameters, responseType: SearchResults.self) { [weak self] result in
            self?.complete(result: result)
        }
    }
}
