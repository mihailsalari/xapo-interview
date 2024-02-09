//
//  MockNetworkManager.swift
//  SwiftNetworkTests
//
//  Created by Mihail Salari on 12/3/23.
//

import Foundation
import XCTest

@testable import SwiftNetwork
public final class MockNetworkManager: NetworkManaging {
    public var responseData: [String: Any] = [:]
    public var error: Error?
    
    public init() { }

    public func get<T>(path: String) async throws -> T where T: Decodable {
        if let error = self.error {
            throw error
        }
        if let data = responseData[path] as? T {
            return data
        }
        throw NetworkError.invalidResponse
    }
    
    public func fetchFullURL<T>(_ urlString: String) async throws -> T where T: Decodable {
        if let error = self.error {
            throw error
        }
        if let data = responseData[urlString] as? T {
            return data
        }
        throw NetworkError.invalidResponse
    }
    
    public func getData(from urlString: String) async throws -> Data {
        if let error = self.error {
            throw error
        }
        if let data = responseData[urlString] as? Data {
            return data
        }
        throw NetworkError.invalidResponse
    }
}

