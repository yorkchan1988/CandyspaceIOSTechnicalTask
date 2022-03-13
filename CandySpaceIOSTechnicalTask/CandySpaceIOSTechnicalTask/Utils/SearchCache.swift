//
//  SearchCache.swift
//  CandySpaceIOSTechnicalTask
//
//  Created by YORK CHAN on 13/3/2022.
//

import Foundation

class SearchCache {
    
    private let UserDefaultKeySearchCache = "UserDefaultKeySearchCache"
    private var memoryCache: [String: Data] = [:]
    private let standardUserDefaults = UserDefaults.standard
    
    static let shared = SearchCache()
    
    private init() {
        loadFromUserDefaults()
    }
    
    private func loadFromUserDefaults() {
        if let object = standardUserDefaults.object(forKey: UserDefaultKeySearchCache) as? [String: Data] {
            memoryCache = object
        }
    }
    
    func addCache(searchText: String, searchResults: SearchResults) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(searchResults) {
            memoryCache[searchText] = encoded
            standardUserDefaults.set(memoryCache, forKey: UserDefaultKeySearchCache)
            standardUserDefaults.synchronize()
        }
    }
    
    func loadCache(searchText: String) -> SearchResults? {
        let decoder = JSONDecoder()
        let data = memoryCache[searchText]
        if let data = data, let decoded = try? decoder.decode(SearchResults.self, from: data) {
            return decoded
        }
        return nil
    }
    
    func removeAllCache() {
        memoryCache = [:]
    }
}
