//
//  ImageCache.swift
//  CandySpaceIOSTechnicalTask
//
//  Created by YORK CHAN on 13/3/2022.
//

import Foundation

// TODO: could do file cache also
class ImageCache {
    
    private static var memoryCache: [String: Data] = [:]
    
    static func addCache(urlString: String, data: Data) {
        memoryCache[urlString] = data
    }
    
    static func loadCache(urlString: String) -> Data? {
        return memoryCache[urlString]
    }
    
    static func removeAllCache() {
        memoryCache = [:]
    }
}
