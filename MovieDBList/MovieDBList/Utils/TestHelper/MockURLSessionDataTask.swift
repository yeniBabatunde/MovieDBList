//
//  MockURLSessionDataTask.swift
//  MovieDBList
//
//  Created by Sharon Omoyeni Babatunde on 05/07/2024.
//

import Foundation

class MockURLSessionDataTask: URLSessionDataTask {
    
    private var closure: () -> Void?

    init(closure: @escaping () -> Void) {
        self.closure = closure
        super.init()
    }

    override func resume() {
        closure()
    }
}

class MockURLSession: URLSession {
    var data: Data?
    var error: Error?

    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return MockURLSessionDataTask {
            completionHandler(self.data, nil, self.error)
        }
    }
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
           return MockURLSessionDataTask {
               completionHandler(self.data, nil, self.error)
           }
       }
    
}
