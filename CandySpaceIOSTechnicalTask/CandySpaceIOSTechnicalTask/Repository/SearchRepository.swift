//
//  SearchRepository.swift
//  CandySpaceIOSTechnicalTask
//
//  Created by YORK CHAN on 12/3/2022.
//

import Foundation

class SearchRepository {
    
    private let networkManager: NetworkManagerProtocol
    private let queueManager: QueueManager
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared, queueManager: QueueManager = QueueManager.shared) {
        self.networkManager = networkManager
        self.queueManager = queueManager
    }
    
    /// Search photos either from the cache or from the network
    /// - Parameter searchText: The text inputted by the user
    /// - Parameter completionHandler: The completion block
    func searchPhotos(searchText: String, completionHandler: ((_ result: Result<SearchResults, NetworkError>) -> Void)?) {
        
        if let searchCache = SearchCache.loadCache(searchText: searchText) {
            print(String(format: "%@ - searchText: %@ -- SearchCache found", #function, searchText))
            completionHandler?(.success(searchCache))
        }
        else {
            print(String(format: "%@ - searchText: %@ -- SearchCache not found", #function, searchText))
            let operation = SearchAPIOperation(searchText: searchText, networkManager: networkManager)
            operation.completionHandler = { [searchText] result in
                switch result {
                case .failure(let error):
                    completionHandler?(.failure(error))
                    break
                case .success(let data):
                    SearchCache.addCache(searchText: searchText, searchResults: data)
                    completionHandler?(.success(data))
                    break
                }
            }
            QueueManager.shared.addOperation(operation)
        }
    }
}
