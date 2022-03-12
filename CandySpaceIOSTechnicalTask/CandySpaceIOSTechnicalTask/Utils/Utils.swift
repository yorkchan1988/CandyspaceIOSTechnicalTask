//
//  Utils.swift
//  CandySpaceIOSTechnicalTask
//
//  Created by YORK CHAN on 12/3/2022.
//

import Foundation

func getAPIKey() -> String? {
    guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
        return nil
    }
    return apiKey
}

func getBaseUrlString() -> String? {
    guard let urlString = Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as? String else {
        return nil
    }
    return urlString
}
