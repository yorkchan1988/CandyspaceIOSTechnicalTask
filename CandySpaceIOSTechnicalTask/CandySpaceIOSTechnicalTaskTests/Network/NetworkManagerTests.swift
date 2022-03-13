//
//  NetworkManagerTest.swift
//  CandySpaceIOSTechnicalTaskTests
//
//  Created by YORK CHAN on 13/3/2022.
//

import Foundation

import XCTest

@testable
import CandySpaceIOSTechnicalTask

class NetworkManagerTests: XCTestCase {
    func test_constructGetUrl() throws {
        // GIVEN
        let parameters = [
            "q":"yellow+flowers",
            "image_type":"photo"
        ]
        let apiKey = "13197033-03eec42c293d2323112b4cca6"
        var components = URLComponents(string: "https://pixabay.com/api/")!
        
        // WHEN
        NetworkManager.shared.constructGetUrl(parameters: parameters, apiKey: apiKey, components: &components)
        
        let url = components.url!
        
        // THEN
        XCTAssert(url.absoluteString.isEqual("https://pixabay.com/api/?q=yellow%2Bflowers&image_type=photo&key=13197033-03eec42c293d2323112b4cca6") || url.absoluteString.isEqual("https://pixabay.com/api/?image_type=photo&q=yellow%2Bflowers&key=13197033-03eec42c293d2323112b4cca6"))
    }
}
