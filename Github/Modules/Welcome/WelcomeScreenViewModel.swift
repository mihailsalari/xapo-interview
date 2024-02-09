//
//  WelcomeScreenViewModel.swift
//  Github
//
//  Created by Mihail Salari on 12/2/23.
//

import Foundation
//
//  WelcomeScreenViewModelProtocol.swift
//  Github
//
//  Created by Mihail Salari on 12/2/23.
//

import SwiftUI
import SwiftNetwork

protocol WelcomeScreenViewModelProtocol: ObservableObject {
    var privacyPolicyURL: URL? { get }
    var termsOfUseURL: URL? { get }
    
    func enterApp()
    func openPrivacyPolicy()
    func openXapo()
    func openTermsOfUse()
}

final class WelcomeScreenViewModel: WelcomeScreenViewModelProtocol {
    var coordinator: any AppCoordinatorProtocol
    
    lazy var privacyPolicyURL: URL? = {
        URL(string: welcome.policyURLString)
    }()
    
    lazy var termsOfUseURL: URL? = {
        URL(string: welcome.termsURLString)
    }()
    
    let welcome = Welcome()
    
    init(coordinator: any AppCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func enterApp() {
        coordinator.showFeedView()
    }
    
    func openPrivacyPolicy() {
        coordinator.openPrivacyPolicy(welcome.policyURLString)
    }
    
    func openXapo() {
        coordinator.openXapo(welcome.xapoURLString)
    }
    
    func openTermsOfUse() {
        coordinator.openTermsOfUse(welcome.termsURLString)
    }
    
    private func open(with string: String) {
        guard let url = URL(string: string) else { return }
        UIApplication.shared.open(url)
    }
}
