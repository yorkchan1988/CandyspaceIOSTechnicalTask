//
//  NetworkError.swift
//  CandySpaceIOSTechnicalTask
//
//  Created by YORK CHAN on 12/3/2022.
//

import Foundation

enum NetworkError  {
    case serverError(String)
    case responseError(String)
    case clientError(String)
}

extension NetworkError : LocalizedError, Equatable {
    public var errorDescription: String? {
        switch self {
        case .serverError(let apiPath):
            return apiPath + "-" + networkServerErrorMessage
        case .responseError(let apiPath):
            return apiPath + " - " + networkResponseErrorMessage
        case .clientError(let apiPath):
            return apiPath + " - " + networkClientErrorMessage
        }
    }
}
