//
//  RepositoryStatsView.swift
//  Github
//
//  Created by Mihail Salari on 12/2/23.
//

import SwiftUI
import SwiftNetwork

struct RepositoryStatsView: View {
    private struct Constants {
        static let spacing: CGFloat = 12
        static let starImageName = "star"
        static let forkImageName = "fork"
    }
    
    let repository: Repository
    
    var body: some View {
        HStack(spacing: Constants.spacing) {
            LanguageView(language: repository.language, colorHex: repository.languageColor)
            StatsView(imageName: Constants.starImageName, count: repository.stars)
            StatsView(imageName: Constants.forkImageName, count: repository.forks)
        }
        .padding(.horizontal)
    }
}
