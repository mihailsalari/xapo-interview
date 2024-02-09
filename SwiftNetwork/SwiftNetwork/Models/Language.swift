//
//  Language.swift
//  SwiftNetwork
//
//  Created by Mihail Salari on 12/3/23.
//

import Foundation

public struct Language: Codable, Identifiable {
    public let id: UUID = UUID()
    public let color: String
    public let url: String
    public let name: String
    public let title: String
}

public typealias Languages = [Language]
