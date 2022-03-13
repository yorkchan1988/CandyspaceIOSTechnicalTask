//
//  ImageCache.swift
//  CandySpaceIOSTechnicalTask
//
//  Created by YORK CHAN on 13/3/2022.
//

import Foundation

class ImageCache {
    
    private let UserDefaultKeyImageCache = "UserDefaultKeyImageCache"
    private var memoryCache: [String: Data] = [:]
    private let standardUserDefaults = UserDefaults.standard
    
    static let shared = ImageCache()
    
    private init() {
        loadFromUserDefaults()
    }
    
    private func loadFromUserDefaults() {
        if let object = standardUserDefaults.object(forKey: UserDefaultKeyImageCache) as? [String: Data] {
            memoryCache = object
        }
    }
    
    func addCache(urlString: String, data: Data) {
        memoryCache[urlString] = data
        standardUserDefaults.set(memoryCache, forKey: UserDefaultKeyImageCache)
        standardUserDefaults.synchronize()
    }
    
    func loadCache(urlString: String) -> Data? {
        return memoryCache[urlString]
    }
    
    func removeAllCache() {
        memoryCache = [:]
    }
}
