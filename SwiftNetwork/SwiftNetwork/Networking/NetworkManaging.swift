//
//  NetworkManaging.swift
//  SwiftNetwork
//
//  Created by Mihail Salari on 12/3/23.
//

import Foundation

public protocol NetworkManaging {
    func get<T: Decodable>(path: String) async throws -> T
    func fetchFullURL<T: Decodable>(_ urlString: String) async throws -> T
    func getData(from urlString: String) async throws -> Data
}
