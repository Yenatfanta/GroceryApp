//
//  MockURLSession.swift
//  GroceryAppTests
//
//  Created by Yenat Feyyisa on 3/5/25.
//

import Foundation
// swiftlint: disable all
class MockURLSession: URLProtocol {
    static var responseData: Data?
    static var responseError: Error?
    static var statusCode: Int = 200
    static var mockResponse: URLResponse?
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    override func startLoading() {
        if let error = MockURLSession.responseError {
            client?.urlProtocol(self, didFailWithError: error)
        } else if let response = MockURLSession.mockResponse {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            if let data = MockURLSession.responseData {
                client?.urlProtocol(self, didLoad: data)
            }
        } else {
            let defaultResponse = HTTPURLResponse(
                url: request.url!,
                statusCode: MockURLSession.statusCode,
                httpVersion: nil,
                headerFields: nil
            )!
            client?.urlProtocol(self, didReceive: defaultResponse, cacheStoragePolicy: .notAllowed)
            if let data = MockURLSession.responseData {
                client?.urlProtocol(self, didLoad: data)
            }
        }
        client?.urlProtocolDidFinishLoading(self)
    }
    override func stopLoading() {}
}
//swiftlint:enable all
