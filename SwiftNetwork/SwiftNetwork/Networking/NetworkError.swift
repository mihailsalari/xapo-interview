//
//  NetworkError.swift
//  SwiftNetwork
//
//  Created by Mihail Salari on 12/3/23.
//

import Foundation

public enum NetworkError: Error {
    case badURL
    case requestFailed(Error)
    case invalidResponse
    case decodingError(Error)
    case requestFailed(withStatusCode: Int, data: Data)
}
