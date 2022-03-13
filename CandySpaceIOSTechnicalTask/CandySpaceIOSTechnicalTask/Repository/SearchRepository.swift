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
    
    func searchPhotos(searchText: String, completionHandler: ((_ result: Result<SearchResults, NetworkError>) -> Void)?) {
        
        let operation = SearchAPIOperation(searchText: searchText, networkManager: NetworkManager.shared)
        operation.completionHandler = completionHandler
        QueueManager.shared.addOperation(operation)
    }
}
