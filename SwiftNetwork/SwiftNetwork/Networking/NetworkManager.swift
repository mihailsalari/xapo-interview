//
//  NetworkManager.swift
//  SwiftNetwork
//
//  Created by Mihail Salari on 12/3/23.
//

import Foundation

public actor NetworkManager: NetworkManaging {
    private let session: URLSessionProtocol
    private let baseURL: String
    
    public init(session: URLSessionProtocol = URLSession.shared, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    public func get<T: Decodable>(path: String) async throws -> T {
        let fullURL = baseURL + path

        guard let url = URL(string: fullURL) else {
            throw NetworkError.badURL
        }

        do {
            let (data, response) = try await session.getData(from: url)

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw NetworkError.invalidResponse
            }

            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                return decodedData
            } catch {
                throw NetworkError.decodingError(error)
            }
        } catch {
            throw NetworkError.requestFailed(error)
        }
    }
}

public extension NetworkManager {
    func fetchFullURL<T: Decodable>(_ urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw NetworkError.badURL
        }

        do {
            let (data, response) = try await session.getData(from: url)

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw NetworkError.invalidResponse
            }

            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw error
        }
    }
}

public extension NetworkManager {
    func getData(from urlString: String) async throws -> Data {
        guard let url = URL(string: urlString) else {
            throw NetworkError.badURL
        }

        let (data, response) = try await session.getData(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        switch httpResponse.statusCode {
        case 200...299:
            return data
        default:
            throw NetworkError.requestFailed(withStatusCode: httpResponse.statusCode, data: data)
        }
    }
}
