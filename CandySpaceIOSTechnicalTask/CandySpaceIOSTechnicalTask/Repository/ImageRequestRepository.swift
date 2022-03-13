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
    
    // by default, assign network manager and queue manager singleton
    // to increase the flexibility of writing unit test, I tend to inject the dependency into the constructor
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared, queueManager: QueueManager = QueueManager.shared) {
        self.networkManager = networkManager
        self.queueManager = queueManager
    }
    
    
    /// Load image either from the cache or from the network
    /// - Parameter urlString: The string of the url
    /// - Parameter completionHandler: The completion block
    func loadImage(urlString: String, completionHandler: ((_ source: Source, _ result: Result<Data, NetworkError>) -> Void)?) {
        
        if let imageCache = ImageCache.loadCache(urlString: urlString) {
            print(String(format: "%@ - urlString: %@ -- ImageCache found", #function, urlString))
            completionHandler?(.cache, .success(imageCache))
        }
        else {
            print(String(format: "%@ - urlString: %@ -- ImageCache not found", #function, urlString))
            operation = ImageRequestOperation(urlString: urlString, networkManager: networkManager)
            if let operation = operation {
                operation.completionHandler = { [urlString] result in
                    switch result {
                    case .failure(let error):
                        completionHandler?(.network, .failure(error))
                        break
                    case .success(let data):
                        ImageCache.addCache(urlString: urlString, data: data)
                        completionHandler?(.network, .success(data))
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
