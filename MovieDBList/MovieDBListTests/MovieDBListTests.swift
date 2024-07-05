//
//  MovieDBListTests.swift
//  MovieDBListTests
//
//  Created by Sharon Omoyeni Babatunde on 02/07/2024.
//

import XCTest
import NetworkHandling
@testable import MovieDBList

final class MovieDBListTests: XCTestCase {
    
    var sut: NetworkHandler!
    var mockSession: MockURLSession!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockSession = MockURLSession()
        sut = NetworkHandler(session: mockSession)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        mockSession = nil
        try super.tearDownWithError()
    }
    
    func testRequestSuccess() {
        let expectation = self.expectation(description: "Request should succeed")
        let testData = """
            {
                "id": 1,
                "title": "Test Movie"
            }
            """.data(using: .utf8)!
        mockSession.data = testData
        
        sut.request(with: "https://api.example.com/movies", method: .GET, body: nil, headers: nil) { (result: Result<TestMovie, Error>) in
            // Then
            switch result {
            case .success(let movie):
                XCTAssertEqual(movie.id, 1)
                XCTAssertEqual(movie.title, "Test Movie")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Request should not fail. Error: \(error)")
            }
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testRequestFailure() {
        let expectation = self.expectation(description: "Request should fail")
        let testError = NSError(domain: "TestError", code: 404, userInfo: nil)
        mockSession.error = testError
        
        sut.request(with: "https://api.example.com/movies", method: .GET, body: nil, headers: nil) { (result: Result<TestMovie, Error>) in
            // Then
            switch result {
            case .success:
                XCTFail("Request should not succeed")
            case .failure(let error):
                XCTAssertEqual((error as NSError).domain, "TestError")
                XCTAssertEqual((error as NSError).code, 404)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testFetchImageSuccess() {
        let expectation = self.expectation(description: "Image fetch should succeed")
        let testImageData = Data(repeating: 0, count: 100) // Simulating image data
        mockSession.data = testImageData
        
        sut.fetchImage(urlString: "\(AppConstants.IMAGE_BASE_URL)/xkNK36hQv8SWiwiQoE7naRfP0zL.jpg") { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data, testImageData)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Image fetch should not fail. Error: \(error)")
            }
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testFetchImageFailure() {
        let expectation = self.expectation(description: "Image fetch should fail")
        let testError = NSError(domain: "TestError", code: 404, userInfo: nil)
        mockSession.error = testError
        mockSession.data = nil
        
        sut.fetchImage(urlString: "\(AppConstants.IMAGE_BASE_URL)/nonexistent.jpg") { result in
            switch result {
            case .success:
                XCTFail("Image fetch should not succeed")
            case .failure(let error):
                XCTAssertEqual((error as NSError).domain, "TestError")
                XCTAssertEqual((error as NSError).code, 404)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testFetchImageInvalidURL() {
        let invalidURLs = ["invalid url", "http://", "https://", "ftp://invalid.com", "http://invalid"]
        
        for urlString in invalidURLs {
            let expectation = self.expectation(description: "Image fetch should fail with invalid URL: \(urlString)")
            
            sut.fetchImage(urlString: urlString) { result in
                switch result {
                case .success:
                    XCTFail("Image fetch should not succeed with invalid URL: \(urlString)")
                case .failure(let error):
                    if let nsError = error as? NSError {
                        // Check for specific error codes related to invalid URLs
                        XCTAssertTrue(
                            nsError.domain == NSURLErrorDomain &&
                            (nsError.code == NSURLErrorUnsupportedURL ||
                             nsError.code == NSURLErrorBadURL ||
                             nsError.code == NSURLErrorCannotFindHost ||
                             nsError.code == NSURLErrorCannotConnectToHost ||
                             nsError.code == -1016),
                            "Expected URL-related error, but got domain: \(nsError.domain), code: \(nsError.code) for URL: \(urlString)"
                        )
                    } else {
                        XCTFail("Expected NSError, but got \(type(of: error)) for URL: \(urlString)")
                    }
                    expectation.fulfill()
                }
            }
            
            waitForExpectations(timeout: 1.0, handler: nil)
        }
    }
}
