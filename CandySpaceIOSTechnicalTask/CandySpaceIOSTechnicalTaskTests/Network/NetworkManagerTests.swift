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
    
    func test_decodeObjectFromData_success() throws {
        // GIVEN
        let response = "{\"total\":31360,\"totalHits\":500,\"hits\":[{\"id\":1127174,\"pageURL\":\"https://pixabay.com/photos/sunflower-flower-plant-petals-1127174/\",\"type\":\"photo\",\"tags\":\"sunflower, flower, plant\",\"previewURL\":\"https://cdn.pixabay.com/photo/2016/01/08/05/24/sunflower-1127174_150.jpg\",\"previewWidth\":150,\"previewHeight\":99,\"webformatURL\":\"https://pixabay.com/get/g09ecf8a5ae9f61a39f7af846affe2a66ed2f5acecb067fade7aca5932f9eb1270cce98088a01d203db9d18f8ac20cfd579e6013b574be04868cbcc27a0ae797b_640.jpg\",\"webformatWidth\":640,\"webformatHeight\":426,\"largeImageURL\":\"https://pixabay.com/get/g3673d94165cea812de47afdf30bce7bc2286a22eb72c4a6cdd6f8977c301df9ea9b35328bcae4c6ea21f7eb4325a5f1e58945e019feb6d4f6b0d5cb27b07daab_1280.jpg\",\"imageWidth\":4752,\"imageHeight\":3168,\"imageSize\":3922163,\"views\":329468,\"downloads\":200349,\"collections\":4461,\"likes\":903,\"comments\":121,\"user_id\":1445608,\"user\":\"mploscar\",\"userImageURL\":\"https://cdn.pixabay.com/user/2016/01/05/14-08-20-943_250x250.jpg\"}]}"
        let data = response.data(using: .utf8)!
        
        // WHEN
        let searchResults = try NetworkManager.shared.decodeObjectFromData(responseType: SearchResults.self, data: data)
        
        // THEN
        XCTAssertEqual(searchResults.hits.count, 1)
        XCTAssertEqual(searchResults.hits[0].id, 1127174)
        XCTAssertEqual(searchResults.hits[0].previewURL, "https://cdn.pixabay.com/photo/2016/01/08/05/24/sunflower-1127174_150.jpg")
        XCTAssertEqual(searchResults.hits[0].largeImageURL, "https://pixabay.com/get/g3673d94165cea812de47afdf30bce7bc2286a22eb72c4a6cdd6f8977c301df9ea9b35328bcae4c6ea21f7eb4325a5f1e58945e019feb6d4f6b0d5cb27b07daab_1280.jpg")
    }
}
