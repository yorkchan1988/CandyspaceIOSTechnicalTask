//
//  SearchCacheTests.swift
//  CandySpaceIOSTechnicalTaskTests
//
//  Created by YORK CHAN on 14/3/2022.
//

import Foundation

import XCTest

@testable
import CandySpaceIOSTechnicalTask

class SearchCacheTests: XCTestCase {
    func test_addCache_loadCache_success() throws {
        // GIVEN
        SearchCache.removeAllCache()
        let searchResults = SearchResults(hits: [Hit(id: 1127174, previewURL: "https://cdn.pixabay.com/photo/2016/01/08/05/24/sunflower-1127174_150.jpg")])
        
        // WHEN
        SearchCache.addCache(searchText: "test", searchResults: searchResults)
        
        // THEN
        let cache = SearchCache.loadCache(searchText: "test")
        XCTAssertEqual(cache, searchResults)
    }
    
    func test_removeAllCache() throws {
        // GIVEN
        SearchCache.removeAllCache()
        let searchResults = SearchResults(hits: [Hit(id: 1127174, previewURL: "https://cdn.pixabay.com/photo/2016/01/08/05/24/sunflower-1127174_150.jpg")])
        SearchCache.addCache(searchText: "test", searchResults: searchResults)
        
        // WHEN
        SearchCache.removeAllCache()
        
        // THEN
        let cache = SearchCache.loadCache(searchText: "test")
        XCTAssertNil(cache)
    }
    
    override func tearDown() {
        super.tearDown()
        SearchCache.removeAllCache()
    }
}
