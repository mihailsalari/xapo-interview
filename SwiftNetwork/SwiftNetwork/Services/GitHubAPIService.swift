//
//  GitHubAPIService.swift
//  SwiftNetwork
//
//  Created by Mihail Salari on 12/3/23.
//

import Combine
import Foundation

enum GitHubAPI {
    case languages
    case repositories(language: String, period: String)
    case readme(username: String, repository: String)
        
    func path(with baseURL: String) -> String {
        switch self {
        case .languages:
            return "/languages"
        case .repositories(let language, let period):
            let query = "?language=\(language)&since=\(period)"
            return "/repositories\(query)"
        case .readme(let username, let repository):
            return baseURL + "\(username)" + "/\(repository)" + "/master/README.md"
        }
    }
}

public protocol GitHubAPIServiceProtocol {
    func fetchLanguages() async throws -> [Language]
    func fetchRepositories(language: String, period: String) async throws -> [Repository]
    func fetchDescription(baseURL: String, repository: Repository) async throws -> Data
    
    func getData(from urlString: String) async throws -> Data
}

public struct GitHubAPIService: GitHubAPIServiceProtocol {
    private let networkManager: NetworkManaging
    private let baseURL: String
    
    public init(networkManager: NetworkManaging, baseURL: String) {
        self.networkManager = networkManager
        self.baseURL = baseURL
    }
    
    public func fetchLanguages() async throws -> [Language] {
        return try await networkManager.get(path: GitHubAPI.languages.path(with: baseURL))
    }
    
    public func fetchRepositories(language: String, period: String) async throws -> [Repository] {
        return try await networkManager.get(path: GitHubAPI.repositories(language: language, period: period).path(with: baseURL))
    }
    
    public func fetchDescription(baseURL: String, repository: Repository) async throws -> Data {
        return try await networkManager.getData(from: GitHubAPI.readme(username: repository.author, repository: repository.name).path(with: baseURL))
    }
    
    public func getData(from urlString: String) async throws -> Data {
        return try await networkManager.getData(from: urlString)
    }
}
