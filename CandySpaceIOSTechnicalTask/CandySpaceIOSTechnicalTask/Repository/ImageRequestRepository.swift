//
//  ImageRequestRepository.swift
//  CandySpaceIOSTechnicalTask
//
//  Created by YORK CHAN on 13/3/2022.
//

import Foundation

class ImageRequestRepository {
    
    private let networkManager: NetworkManagerProtocol
    private let queueManager: QueueManager
    private var operation: ImageRequestOperation?
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared, queueManager: QueueManager = QueueManager.shared) {
        self.networkManager = networkManager
        self.queueManager = queueManager
    }
    
    func loadImage(urlString: String, completionHandler: ((_ result: Result<Data, NetworkError>) -> Void)?) {
        
        operation = ImageRequestOperation(urlString: urlString, networkManager: networkManager)
        if let operation = operation {
            operation.completionHandler = completionHandler
            QueueManager.shared.addOperation(operation)
        }
    }
    
    func cancelImageLoading() {
        operation?.cancel()
    }
}
