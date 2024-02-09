//
//  GitHubAPIServiceTests.swift
//  SwiftNetworkTests
//
//  Created by Mihail Salari on 12/3/23.
//

import Foundation
import XCTest
import SwiftUI

@testable import SwiftNetwork
final class GitHubAPIServiceTests: XCTestCase {
    private var mockNetworkManager: MockNetworkManager!
    private var gitHubAPIService: GitHubAPIService!
    private let baseURL = "https://google.com"
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockNetworkManager = MockNetworkManager()
        gitHubAPIService = GitHubAPIService(networkManager: mockNetworkManager, baseURL: baseURL)
    }

    override func tearDownWithError() throws {
        mockNetworkManager = nil
        gitHubAPIService = nil
        try super.tearDownWithError()
    }

    func testFetchLanguagesSuccess() async throws {
        // Given
        let expectedLanguages: [Language] = [.init(color: "#fff000", url: baseURL, name: "Swift", title: "Swift")]
        mockNetworkManager.responseData[GitHubAPI.languages.path(with: baseURL)] = expectedLanguages

        // When
        do {
            let languages = try await gitHubAPIService.fetchLanguages()

            // Then
            XCTAssertEqual(languages.count, expectedLanguages.count)
            XCTAssertEqual(languages.first?.name, "Swift")
        } catch {
            XCTFail("Expected successful response, received error: \(error)")
        }
    }

    func testFetchLanguagesFailure() async throws {
        // Given
        mockNetworkManager.error = NetworkError.invalidResponse
        
        // When
        do {
            _ = try await gitHubAPIService.fetchLanguages()
            
            // Then
            XCTFail("Expected an error, but the call succeeded")
        } catch {
            // Then: Verify that the error is of the expected type
            if case NetworkError.invalidResponse = error {
                // Success: Correct error type caught
            } else {
                XCTFail("Expected NetworkError.invalidResponse, received different error: \(error)")
            }
        }
    }
}
