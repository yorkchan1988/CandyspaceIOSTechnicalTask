//
//  SearchAPIOperation.swift
//  CandySpaceIOSTechnicalTask
//
//  Created by YORK CHAN on 12/3/2022.
//

import Foundation

class SearchAPIOperation: NetworkOperation<SearchResults> {
    private let apiPath: String = ""
    private let networkManager: NetworkManagerProtocol
    private let searchText: String
    
    // by default, assign network manager and queue manager singleton
    // to increase the flexibility of writing unit test, I tend to inject the dependency into the constructor
    init(searchText: String, networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.searchText = searchText.replacingOccurrences(of: " ", with: "+")
        self.networkManager = networkManager
    }
       
    override func main() {
        
        let parameters = [
            "q":searchText,
            "image_type":"photo",
            "per_page":"100"
        ]
        
        networkManager.requestData(apiPath: apiPath, httpMethod: .get, parameters: parameters) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.complete(result: .failure(error))
                break
            case .success(let data):
                do {
                    let searchResults = try JSONDecoder().decode(SearchResults.self, from: data)
                    self?.complete(result: .success(searchResults))
                }
                catch {
                    self?.complete(result: .failure(NetworkError.responseError))
                }
                break
            }
        }
    }
}
