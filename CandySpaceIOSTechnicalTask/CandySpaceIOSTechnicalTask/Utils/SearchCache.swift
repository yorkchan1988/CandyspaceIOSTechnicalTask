//
//  SearchCache.swift
//  CandySpaceIOSTechnicalTask
//
//  Created by YORK CHAN on 13/3/2022.
//

import Foundation

class SearchCache {
    
    private static var memoryCache: [String: Data] = [:]
    
    static func addCache(searchText: String, searchResults: SearchResults) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(searchResults) {
            memoryCache[searchText] = encoded
        }
    }
    
    static func loadCache(searchText: String) -> SearchResults? {
        let decoder = JSONDecoder()
        let data = memoryCache[searchText]
        if let data = data, let decoded = try? decoder.decode(SearchResults.self, from: data) {
            return decoded
        }
        return nil
    }
    
    static func removeAllCache() {
        memoryCache = [:]
    }
}
