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
        
        // WHEN
        let expectation = expectation(description: "Test Search Photos API")
        repository.searchPhotos(searchText: "yellow flowers") { result in
            // THEN
            switch result {
            case .success(let searchResults):
                XCTAssertEqual(searchResults.hits.count, 1)
                XCTAssertEqual(searchResults.hits[0].id, 1127174)
                XCTAssertEqual(searchResults.hits[0].previewURL, "https://cdn.pixabay.com/photo/2016/01/08/05/24/sunflower-1127174_150.jpg")
                XCTAssertEqual(searchResults.hits[0].largeImageURL, "https://pixabay.com/get/g3673d94165cea812de47afdf30bce7bc2286a22eb72c4a6cdd6f8977c301df9ea9b35328bcae4c6ea21f7eb4325a5f1e58945e019feb6d4f6b0d5cb27b07daab_1280.jpg")
                break
            case .failure(let error):
                XCTAssertNil(error)
                break
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
    }
}
