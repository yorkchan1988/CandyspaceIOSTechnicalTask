//
//  ImageRequestRepositoryTests.swift
//  CandySpaceIOSTechnicalTaskTests
//
//  Created by YORK CHAN on 13/3/2022.
//

import Foundation

import XCTest

@testable
import CandySpaceIOSTechnicalTask

class ImageRequestRepositoryTests: XCTestCase {
    func test_loadImage_success() throws {
        // GIVEN
        let networkManager = FakeNetworkManager()
        let repository = ImageRequestRepository(networkManager: networkManager)
        ImageCache.removeAllCache()
        
        // WHEN
        let expectation = expectation(description: "Test Load Image")
        repository.loadImage(urlString: "https://cdn.pixabay.com/photo/2016/01/08/05/24/sunflower-1127174_150.jpg") { source, result in
            
            // THEN
            XCTAssertEqual(source, .network)
            
            switch result {
            case .success(let data):
                do {
                    let expectedData = try Data(contentsOf: URL(string: "https://cdn.pixabay.com/photo/2016/01/08/05/24/sunflower-1127174_150.jpg")!)
                    XCTAssertEqual(data, expectedData)
                }
                catch {
                    XCTAssertNil(error)
                }
                break
            case .failure(let error):
                XCTAssertNil(error)
                break
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
    }
    
    func test_loadImage_fromCache_success() throws {
        
        // GIVEN
        let networkManager = FakeNetworkManager()
        let repository = ImageRequestRepository(networkManager: networkManager)
        ImageCache.removeAllCache()
        
        // WHEN
        let expectation = expectation(description: "Test Load Image")
        repository.loadImage(urlString: "https://cdn.pixabay.com/photo/2016/01/08/05/24/sunflower-1127174_150.jpg") { source, result in
            
            // THEN
            XCTAssertEqual(source, .network)
            
            repository.loadImage(urlString: "https://cdn.pixabay.com/photo/2016/01/08/05/24/sunflower-1127174_150.jpg") { source, result in
                
                // THEN
                XCTAssertEqual(source, .cache)
                
                switch result {
                case .success(let data):
                    do {
                        let expectedData = try Data(contentsOf: URL(string: "https://cdn.pixabay.com/photo/2016/01/08/05/24/sunflower-1127174_150.jpg")!)
                        XCTAssertEqual(data, expectedData)
                    }
                    catch {
                        XCTAssertNil(error)
                    }
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
