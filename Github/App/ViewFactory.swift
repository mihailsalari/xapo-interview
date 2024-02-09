//
//  ViewFactory.swift
//  Github
//
//  Created by Mihail Salari on 12/3/23.
//

import Foundation
import SwiftUI
import SwiftNetwork

protocol ViewFactory {
    func createSplashView(coordinator: any AppCoordinatorProtocol) -> AnyView
    func createWelcomeScreenView(coordinator: any AppCoordinatorProtocol) -> AnyView
    func createRepositoriesView(coordinator: any AppCoordinatorProtocol) -> AnyView
    func createRepositoryDetailView(repository: Repository, viewModel: RepositoryViewModel, coordinator: any AppCoordinatorProtocol) -> AnyView
    func createShareSheet(with url: String) -> AnyView
}

struct DefaultViewFactory: ViewFactory {
    func createSplashView(coordinator: any AppCoordinatorProtocol) -> AnyView {
        AnyView(SplashView(coordinator: coordinator))
    }
    
    func createWelcomeScreenView(coordinator: any AppCoordinatorProtocol) -> AnyView {
        return AnyView(WelcomeScreenView(viewModel: WelcomeScreenViewModel(coordinator: coordinator), coordinator: coordinator))
    }
    
    func createRepositoriesView(coordinator: any AppCoordinatorProtocol) -> AnyView {
        let viewModel = RepositoryViewModel(gitHubAPIService: GitHubAPIService(networkManager: NetworkManager(baseURL: AppConstants.githubAPIURLString),
                                                                               baseURL: AppConstants.githubAPIURLString))
        return AnyView(RepositoriesView(viewModel: viewModel, coordinator: coordinator))
    }
    
    func createRepositoryDetailView(repository: SwiftNetwork.Repository, viewModel: RepositoryViewModel, coordinator: any AppCoordinatorProtocol) -> AnyView {
        AnyView(RepositoryDetailView(viewModel: viewModel, repository: repository, coordinator: coordinator))
    }
    
    func createShareSheet(with url: String) -> AnyView {
        return AnyView(ShareSheet(activityItems: [URL(string: url)!]))
    }
}
