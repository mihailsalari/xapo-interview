//
//  RepositoryViewModel.swift
//  Github
//
//  Created by Mihail Salari on 12/2/23.
//

import Combine
import SwiftUI
import SwiftNetwork

protocol RepositoryViewModelProtocol: ObservableObject {
    var repositories: [Repository] { get }
    var isLoading: Bool { get }
    var isDescriptionLoading: Bool { get }
    var filter: RepositoryViewModel.Filter { get set }
    var language: RepositoryViewModel.Language { get set }
    var selectedRepository: Repository? { get set }
    var showDetail: Bool { get set }
    var markdownContent: String? { get }

    func fetchRepositories() async
    func fetchDescription(from repository: Repository) async
    func selectRepository(_ repository: Repository)
    func clearSelection()
    func image(for urlString: String) -> UIImage
}

final class RepositoryViewModel: ObservableObject {
    enum Filter: String, CaseIterable {
        case daily = "daily"
        case weekly = "weekly"
        case monthly = "monthly"
    }
    
    // FIXME: - Default languages are used for BETA version only, for the next release, we need to parse and show the languages.
    enum Language: String, CaseIterable {
        case swift = "swift"
        case python = "python"
        case java = "java"
        case javascript = "javascript"
    }
    
    @Published var toast: Toast?

    @Published var repositories: Repositories = []
    @Published var isLoading = false
    @Published var isDesriptionLoading = false
    
    @Published var filter: Filter = .weekly
    @Published var language: Language = .swift
    
    @Published var selectedRepository: Repository?
    @Published var showDetail = false
    
    @Published private var imageCache = [String: UIImage]()
    
    private let gitHubAPIService: GitHubAPIService
    
    @Published var markdownContent: String?
    
    init(gitHubAPIService: GitHubAPIService) {
        self.gitHubAPIService = gitHubAPIService
    }
    
    func fetchRepositories() async {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        do {
            let fetchedRepositories = try await gitHubAPIService.fetchRepositories(language: language.rawValue, period: filter.rawValue)
            await MainActor.run {
                self.repositories = fetchedRepositories
                self.isLoading = false
            }
        } catch {
            debugPrint("Error fetching repositories: \(error)")
            await MainActor.run {
                self.isLoading = false
                self.toast = Toast(message: "Failed to fetch repositories.".localized, type: .error)
            }
        }
    }
    
    func fetchDescription(from repository: Repository) async {
        DispatchQueue.main.async {
            self.markdownContent = nil
            self.isDesriptionLoading = true
        }
        do {
            let data = try await gitHubAPIService.fetchDescription(baseURL: AppConstants.rawGithubAPI, repository: repository)
            DispatchQueue.main.async {
                self.markdownContent = String(decoding: data, as: UTF8.self).deleteHTMLTags
                self.isDesriptionLoading = false
            }
        } catch {
            await MainActor.run {
                markdownContent = nil
                self.isDesriptionLoading = false
                self.toast = Toast(message: "Failed to load the README.me content file.".localized, type: .error)
            }
        }
    }
    
    func selectRepository(_ repository: Repository) {
        selectedRepository = repository
        showDetail = true
    }
    
    func clearSelection() {
        selectedRepository = nil
        showDetail = false
    }
    
    func image(for urlString: String) -> UIImage {
        if let image = imageCache[urlString] {
            return image
        } else {
            let placeholderImage = UIImage(named: "default-avatar") ?? UIImage()
            Task {
                do {
                    let imageData = try await gitHubAPIService.getData(from: urlString)
                    if let image = UIImage(data: imageData) {
                        await MainActor.run {
                            self.imageCache[urlString] = image
                        }
                    } else {
                        handleImageError(urlString: urlString, error: nil)
                    }
                } catch {
                    handleImageError(urlString: urlString, error: error)
                }
            }
            return placeholderImage
        }
    }

    private func handleImageError(urlString: String, error: Error?) {
        if let error = error {
            debugPrint("Error fetching image for URL \(urlString): \(error)")
        } else {
            debugPrint("Invalid image data for URL \(urlString)")
        }

        // TODO: - Implement strategy for user feedback, retry mechanism, or analytics
        // For example, we might want to show a default error image or a retry button to the user.
        // We can also report this error to our analytics system for further investigation.
    }
}
