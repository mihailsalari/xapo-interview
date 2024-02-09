//
//  MockViewFactory.swift
//  GithubTests
//
//  Created by Mihail Salari on 12/3/23.
//

import Foundation
import XCTest
import SwiftUI
import SwiftNetwork

@testable import Github
final class MockViewFactory: ViewFactory {
    var currentViewType: String = ""

    func createSplashView(coordinator: any AppCoordinatorProtocol) -> AnyView {
        currentViewType = "SplashView"
        return AnyView(Text("MockSplashView"))
    }

    func createWelcomeScreenView(coordinator: any AppCoordinatorProtocol) -> AnyView {
        currentViewType = "WelcomeScreenView"
        return AnyView(Text("MockWelcomeScreenView"))
    }

    func createRepositoriesView(coordinator: any AppCoordinatorProtocol) -> AnyView {
        currentViewType = "RepositoriesView"
        return AnyView(Text("MockRepositoriesView"))
    }

    func createRepositoryDetailView(repository: Repository, viewModel: RepositoryViewModel, coordinator: any AppCoordinatorProtocol) -> AnyView {
        currentViewType = "RepositoryDetailView"
        return AnyView(Text("MockRepositoryDetailView"))
    }

    func createShareSheet(with url: String) -> AnyView {
        currentViewType = "ShareSheet"
        return AnyView(Text("MockShareSheet"))
    }
}
