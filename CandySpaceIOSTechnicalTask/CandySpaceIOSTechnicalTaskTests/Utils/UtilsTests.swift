//
//  UtilsTest.swift
//  CandySpaceIOSTechnicalTaskTests
//
//  Created by YORK CHAN on 12/3/2022.
//

import Foundation

import XCTest

@testable
import CandySpaceIOSTechnicalTask

class UtilsTests: XCTestCase {
    func test_getAPIKey() throws {
        // GIVEN
        
        // WHEN
        let apiKey = getAPIKey()
        
        // THEN
        XCTAssertEqual(apiKey, "13197033-03eec42c293d2323112b4cca6")
    }
    
    func test_getBaseUrlString() throws {
        // GIVEN
        
        // WHEN
        let baseUrlString = getBaseUrlString()
        
        // THEN
        XCTAssertEqual(baseUrlString, "https://pixabay.com/api/")
    }
}
