//
//  MockURLSession.swift
//  SwiftNetworkTests
//
//  Created by Mihail Salari on 12/3/23.
//

import Foundation
import XCTest

@testable import SwiftNetwork
public final class MockURLSession: URLSessionProtocol {
    public var data: Data?
    public var response: URLResponse?
    public var error: Error?

    public func getData(from url: URL) async throws -> (Data, URLResponse) {
        if let error = self.error {
            throw error
        }
        return (self.data ?? Data(), self.response ?? URLResponse())
    }
}
