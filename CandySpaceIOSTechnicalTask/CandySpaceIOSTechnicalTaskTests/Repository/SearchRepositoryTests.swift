//
//  SearchRepositoryTest.swift
//  CandySpaceIOSTechnicalTaskTests
//
//  Created by YORK CHAN on 12/3/2022.
//

import Foundation

import XCTest

@testable
import CandySpaceIOSTechnicalTask

class SearchRepositoryTests: XCTestCase {
    func test_searchPhotos_success() throws {
        // GIVEN
        let networkManager = FakeNetworkManager()
        let repository = SearchRepository(networkManager: networkManager)
        ImageCache.removeAllCache()
        
        // WHEN
        let expectation = expectation(description: "Test Search Photos API")
        repository.searchPhotos(searchText: "yellow flowers") { source, result in
            // THEN
            XCTAssertEqual(source, .network)
            
            switch result {
            case .success(let searchResults):
                XCTAssertEqual(searchResults.hits.count, 1)
                XCTAssertEqual(searchResults.hits[0].id, 1127174)
                XCTAssertEqual(searchResults.hits[0].previewURL, "https://cdn.pixabay.com/photo/2016/01/08/05/24/sunflower-1127174_150.jpg")
                break
            case .failure(let error):
                XCTAssertNil(error)
                break
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
    }
    
    func test_searchPhotos_fromCache_success() throws {
        
        // GIVEN
        let networkManager = FakeNetworkManager()
        let repository = SearchRepository(networkManager: networkManager)
        ImageCache.removeAllCache()
        
        // WHEN
        let expectation = expectation(description: "Test Search Photos API")
        repository.searchPhotos(searchText: "yellow flowers") { source, result in
            // THEN
            XCTAssertEqual(source, .network)
            
            repository.searchPhotos(searchText: "yellow flowers") { source, result in
                // THEN
                XCTAssertEqual(source, .cache)
                switch result {
                case .success(let searchResults):
                    XCTAssertEqual(searchResults.hits.count, 1)
                    XCTAssertEqual(searchResults.hits[0].id, 1127174)
                    XCTAssertEqual(searchResults.hits[0].previewURL, "https://cdn.pixabay.com/photo/2016/01/08/05/24/sunflower-1127174_150.jpg")
                    break
                case .failure(let error):
                    XCTAssertNil(error)
                    break
                }
                
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5)
        
    }
}
