//
//  FakeNetworkManager.swift
//  CandySpaceIOSTechnicalTaskTests
//
//  Created by YORK CHAN on 13/3/2022.
//

import Foundation
@testable import CandySpaceIOSTechnicalTask

class FakeNetworkManager: NetworkManagerProtocol {
    
    func requestData<T>(apiPath: String, httpMethod: HTTPMethod, parameters: [String : String], responseType: T.Type, completionHandler: @escaping (Result<T, NetworkError>) -> ()) where T : Decodable, T : Encodable {
        
        
    }
}
