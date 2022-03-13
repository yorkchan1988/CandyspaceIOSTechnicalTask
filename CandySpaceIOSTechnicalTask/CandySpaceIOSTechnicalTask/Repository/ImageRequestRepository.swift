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
    
    
    /// Load image either from the cache or from the network
    /// - Parameter urlString: The string of the url
    /// - Parameter completionHandler: The completion block
    func loadImage(urlString: String, completionHandler: ((_ result: Result<Data, NetworkError>) -> Void)?) {
        
        if let imageCache = ImageCache.shared.loadCache(urlString: urlString) {
            print(String(format: "%@ - urlString: %@ -- ImageCache found", #function, urlString))
            completionHandler?(.success(imageCache))
        }
        else {
            print(String(format: "%@ - urlString: %@ -- ImageCache not found", #function, urlString))
            operation = ImageRequestOperation(urlString: urlString, networkManager: networkManager)
            if let operation = operation {
                operation.completionHandler = { [urlString] result in
                    switch result {
                    case .failure(let error):
                        completionHandler?(.failure(error))
                        break
                    case .success(let data):
                        ImageCache.shared.addCache(urlString: urlString, data: data)
                        completionHandler?(.success(data))
                        break
                    }
                }
                QueueManager.shared.addOperation(operation)
            }
        }
    }
    
    func cancelImageLoading() {
        operation?.cancel()
    }
}
