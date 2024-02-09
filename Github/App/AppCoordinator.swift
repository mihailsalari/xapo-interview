//
//  AppCoordinator.swift
//  Github
//
//  Created by Mihail Salari on 12/2/23.
//

import Foundation
import SwiftUI
import SwiftNetwork

protocol AppCoordinatorProtocol: ObservableObject {
    func start() -> AnyView
    
    func showWelcomeScreen()
    func showFeedView()
    func showDetailsView(repository: Repository, viewModel: RepositoryViewModel) -> AnyView
    func showShareScreen(with url: String) -> AnyView

    func openPrivacyPolicy(_ urlString: String)
    func openTermsOfUse(_ urlString: String)
    func openExternalLink(_ urlString: String)
    func openXapo(_ urlString: String)
}

final class AppCoordinator: ObservableObject, AppCoordinatorProtocol {
    enum Screen {
        case splash, welcome, feed
    }

    @Published var currentScreen: Screen = .splash
    private let viewFactory: ViewFactory

    init(viewFactory: ViewFactory) {
        self.viewFactory = viewFactory
    }

    func start() -> AnyView {
        switch currentScreen {
        case .splash:
            return viewFactory.createSplashView(coordinator: self)
        case .welcome:
            return viewFactory.createWelcomeScreenView(coordinator: self)
        case .feed:
            return viewFactory.createRepositoriesView(coordinator: self)
        }
    }

    func showWelcomeScreen() {
        withAnimation {
            currentScreen = .welcome
        }
    }

    func showFeedView() {
        withAnimation {
            currentScreen = .feed
        }
    }

    func showDetailsView(repository: Repository, viewModel: RepositoryViewModel) -> AnyView {
        return viewFactory.createRepositoryDetailView(repository: repository, viewModel: viewModel, coordinator: self)
    }

    func showShareScreen(with url: String) -> AnyView {
        return viewFactory.createShareSheet(with: url)
    }

    func openPrivacyPolicy(_ urlString: String) {
        openExternalLink(urlString)
    }

    func openTermsOfUse(_ urlString: String) {
        openExternalLink(urlString)
    }

    func openXapo(_ urlString: String) {
        openExternalLink(urlString)
    }
    
    func openExternalLink(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url)
    }
}
