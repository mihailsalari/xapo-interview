//
//  Repository+TestFactory.swift
//  GithubTests
//
//  Created by Mihail Salari on 12/3/23.
//

import Foundation
import SwiftNetwork

extension Repository {
    static func make(author: String = "Dummy Author",
                     name: String = "Dummy Name",
                     avatar: String = "https://example.com/avatar.png",
                     url: String = "https://example.com",
                     description: String = "Dummy Description",
                     language: String = "Swift",
                     languageColor: String = "#ffffff",
                     stars: Int = 100,
                     forks: Int = 50,
                     currentPeriodStars: Int = 10,
                     builtBy: [Contributor] = [Contributor.make()]) -> Repository {
        return Repository(author: author, name: name, avatar: avatar, url: url,
                          description: description, language: language,
                          languageColor: languageColor, stars: stars, forks: forks,
                          currentPeriodStars: currentPeriodStars, builtBy: builtBy)
    }
}
