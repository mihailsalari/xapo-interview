//
//  Contributor+TestFactory.swift
//  GithubTests
//
//  Created by Mihail Salari on 12/3/23.
//

import Foundation
import SwiftNetwork

extension Contributor {
    static func make(username: String = "Dummy User",
                     href: String = "https://example.com/user",
                     avatar: String = "https://example.com/avatar.png") -> Contributor {
        return Contributor(username: username, href: href, avatar: avatar)
    }
}
