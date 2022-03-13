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
