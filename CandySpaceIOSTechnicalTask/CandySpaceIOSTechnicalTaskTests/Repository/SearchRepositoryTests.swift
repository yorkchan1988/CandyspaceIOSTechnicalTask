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
        
        
        // WHEN
        let apiKey = getAPIKey()
        
        // THEN
        XCTAssertEqual(apiKey, "13197033-03eec42c293d2323112b4cca6")
    }
}
