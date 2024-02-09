//
//  AppCoordinatorTests.swift
//  GithubTests
//
//  Created by Mihail Salari on 12/3/23.
//

import Foundation
import XCTest
import SwiftUI
import SwiftNetwork

@testable import Github
final class AppCoordinatorTests: XCTestCase {
    var coordinator: AppCoordinator!
    var mockViewFactory: MockViewFactory!

    override func setUp() {
        super.setUp()
        mockViewFactory = MockViewFactory()
        coordinator = AppCoordinator(viewFactory: mockViewFactory)
    }

    override func tearDown() {
        coordinator = nil
        mockViewFactory = nil
        super.tearDown()
    }
    
    func testStartWithSplashScreen() {
        _ = coordinator.start()
        XCTAssertEqual(mockViewFactory.currentViewType, "SplashView")
    }

    func testShowWelcomeScreen() {
        coordinator.showWelcomeScreen()
        _ = coordinator.start()
        XCTAssertEqual(mockViewFactory.currentViewType, "WelcomeScreenView")
    }

    func testShowFeedView() {
        coordinator.showFeedView()
        _ = coordinator.start()
        XCTAssertEqual(mockViewFactory.currentViewType, "RepositoriesView")
    }
    
    func testShowDetailsView() {
        let dummyRepository: Repository = .make()
        let dummyViewModel = RepositoryViewModel(gitHubAPIService: .init(networkManager: NetworkManager(baseURL: AppConstants.githubAPIURLString),
                                                                         baseURL: AppConstants.githubAPIURLString))
        
        _ = coordinator.showDetailsView(repository: dummyRepository, viewModel: dummyViewModel)
        XCTAssertEqual(mockViewFactory.currentViewType, "RepositoryDetailView")
    }
    
    func testShowShareScreen() {
        let dummyUrl = "https://example.com"
        _ = coordinator.showShareScreen(with: dummyUrl)
        XCTAssertEqual(mockViewFactory.currentViewType, "ShareSheet")
    }
}
