//
//  Repository.swift
//  SwiftNetwork
//
//  Created by Mihail Salari on 12/3/23.
//

import Foundation

public struct Repository: Codable, Identifiable {
    public let id = UUID()
    public let author: String
    public let name: String
    public let avatar: String
    public let url: String
    public let description: String
    public let language: String
    public let languageColor: String
    public let stars: Int
    public let forks: Int
    public let currentPeriodStars: Int
    public let builtBy: [Contributor]
    
    public var fullName: String {
        return "\(author) / \(name)"
    }

    public init(author: String, name: String, avatar: String, url: String, description: String,
                language: String, languageColor: String, stars: Int, forks: Int,
                currentPeriodStars: Int, builtBy: [Contributor]) {
        self.author = author
        self.name = name
        self.avatar = avatar
        self.url = url
        self.description = description
        self.language = language
        self.languageColor = languageColor
        self.stars = stars
        self.forks = forks
        self.currentPeriodStars = currentPeriodStars
        self.builtBy = builtBy
    }
}

public struct Contributor: Codable {
    public let username: String
    public let href: String
    public let avatar: String

    public init(username: String, href: String, avatar: String) {
        self.username = username
        self.href = href
        self.avatar = avatar
    }
}

public typealias Repositories = [Repository]
