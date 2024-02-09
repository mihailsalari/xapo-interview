//
//  GithubApp.swift
//  Github
//
//  Created by Mihail Salari on 12/2/23.
//

import SwiftUI
import SwiftNetwork

@main
struct GithubApp: App {
    @StateObject var coordinator: AppCoordinator

    init() {
        let viewFactory = DefaultViewFactory()
        _coordinator = StateObject(wrappedValue: AppCoordinator(viewFactory: viewFactory))
    }

    var body: some Scene {
        WindowGroup {
            coordinator.start()
        }
    }
}
