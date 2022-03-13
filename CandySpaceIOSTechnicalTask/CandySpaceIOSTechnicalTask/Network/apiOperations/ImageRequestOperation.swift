//
//  ImageRequestOperation.swift
//  CandySpaceIOSTechnicalTask
//
//  Created by YORK CHAN on 13/3/2022.
//

import Foundation

class ImageRequestOperation: NetworkOperation<Data> {
    
    private let networkManager: NetworkManagerProtocol
    private let urlString: String
    
    // by default, assign network manager and queue manager singleton
    // to increase the flexibility of writing unit test, I tend to inject the dependency into the constructor
    init(urlString: String, networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.urlString = urlString
        self.networkManager = networkManager
    }
       
    override func main() {
        
        networkManager.requestImage(urlString: urlString) { [weak self] result in
            self?.complete(result: result)
        }
    }
}
