//
//  NetworkManagerTests.swift
//  SwiftNetworkTests
//
//  Created by Mihail Salari on 12/3/23.
//

import Foundation
import XCTest

@testable import SwiftNetwork
final class NetworkManagerTests: XCTestCase {
    var mockSession: MockURLSession!
    var networkManager: NetworkManager!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockSession = MockURLSession()
        networkManager = NetworkManager(session: mockSession, baseURL: "https://example.com")
    }

    override func tearDownWithError() throws {
        mockSession = nil
        networkManager = nil
        try super.tearDownWithError()
    }

    func testGetSuccess() async throws {
        // Given
        let expectedData = "{\"key\": \"value\"}".data(using: .utf8)!
        let response = HTTPURLResponse(url: URL(string: "https://example.com/path")!,
                                       statusCode: 200, httpVersion: nil, headerFields: nil)!
        mockSession.data = expectedData
        mockSession.response = response

        // When
        do {
            let result: [String: String] = try await networkManager.get(path: "/path")

            // Then
            XCTAssertEqual(result["key"], "value")
        } catch {
            XCTFail("Expected successful response, received error: \(error)")
        }
    }
}

