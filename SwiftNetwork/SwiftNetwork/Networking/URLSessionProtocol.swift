//
//  URLSessionProtocol.swift
//  SwiftNetwork
//
//  Created by Mihail Salari on 12/3/23.
//

import Foundation

public protocol URLSessionProtocol {
    func getData(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {
    public func getData(from url: URL) async throws -> (Data, URLResponse) {
        try await data(from: url)
    }
}
