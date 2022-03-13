//
//  NetworkError.swift
//  CandySpaceIOSTechnicalTask
//
//  Created by YORK CHAN on 12/3/2022.
//

import Foundation

enum NetworkError  {
    case serverError
    case responseError
    case clientError
}

extension NetworkError : LocalizedError, Equatable {
    public var errorDescription: String? {
        switch self {
        case .serverError:
            return networkServerErrorMessage
        case .responseError:
            return networkResponseErrorMessage
        case .clientError:
            return networkClientErrorMessage
        }
    }
}
