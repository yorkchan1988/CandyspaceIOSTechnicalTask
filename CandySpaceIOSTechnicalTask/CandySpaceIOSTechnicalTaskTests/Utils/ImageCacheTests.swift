//
//  ImageCacheTests.swift
//  CandySpaceIOSTechnicalTaskTests
//
//  Created by YORK CHAN on 14/3/2022.
//

import Foundation

import XCTest

@testable
import CandySpaceIOSTechnicalTask

class ImageCacheTests: XCTestCase {
    func test_addCache_loadCache_success() throws {
        // GIVEN
        ImageCache.removeAllCache()
        
        // WHEN
        ImageCache.addCache(urlString: "test_url", data: "test_data".data(using: .utf8)!)
        
        // THEN
        let cache = ImageCache.loadCache(urlString: "test_url")
        XCTAssertEqual(cache, "test_data".data(using: .utf8)!)
    }
    
    func test_removeAllCache() throws {
        // GIVEN
        ImageCache.removeAllCache()
        ImageCache.addCache(urlString: "test_url", data: "test_data".data(using: .utf8)!)
        
        // WHEN
        ImageCache.removeAllCache()
        
        // THEN
        let cache = ImageCache.loadCache(urlString: "test_url")
        XCTAssertNil(cache)
    }
    
    override func tearDown() {
        super.tearDown()
        ImageCache.removeAllCache()
    }
}
