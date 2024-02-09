//
//  RepositoriesView.swift
//  Github
//
//  Created by Mihail Salari on 12/2/23.
//

import Foundation
import SwiftUI
import UIKit

struct RepositoriesView: View {
    private struct Constants {
        static let title = "Repositories".localized
        
        static let filterTitle = "Filter".localized
        static let filterImageName = "globe"
        
        static let languageTitle = "Languages".localized
        static let languageImageName = "line.horizontal.3.decrease.circle"
        
        static let checkmarkImageName = "checkmark"
    }
        
    @ObservedObject var viewModel: RepositoryViewModel
    var coordinator: any AppCoordinatorProtocol

    var body: some View {
        NavigationView {
            List(viewModel.repositories) { repository in
                RepositoryRow(viewModel: viewModel, repository: repository)
                    .onTapGesture { viewModel.selectRepository(repository) }
            }
            .listStyle(SidebarListStyle())
            .listRowSpacing(10.0)
            .accessibility(identifier: .repositoriesTableView)
            .refreshable { await viewModel.fetchRepositories() }
            .navigationTitle(Constants.title)
            .toast(toast: $viewModel.toast)
            .toolbar { toolbarContent }
            .onAppear {
                Task {
                    await viewModel.fetchRepositories()
                }
            }
            .onDisappear {
                viewModel.toast = nil
            }
            .fullScreenCover(isPresented: $viewModel.showDetail) {
                if let selectedRepository = viewModel.selectedRepository {
                    coordinator.showDetailsView(repository: selectedRepository, viewModel: viewModel)
                }
            }
        }
        .overlay(loadingOverlay)
    }

    private var toolbarContent: some ToolbarContent {
        Group {
            ToolbarItem(placement: .navigationBarTrailing) {
                filterMenu
            }
            ToolbarItem(placement: .navigationBarLeading) {
                languageMenu
            }
        }
    }
    
    private var filterMenu: some View {
        Menu {
            ForEach(RepositoryViewModel.Filter.allCases, id: \.self) { filter in
                selectionButton(for: filter, isSelected: filter == viewModel.filter) {
                    viewModel.filter = filter
                    Task { await viewModel.fetchRepositories() }
                }
            }
        } label: {
            Label(Constants.filterTitle, systemImage: Constants.filterImageName)
        }
    }

    private var languageMenu: some View {
        Menu {
            ForEach(RepositoryViewModel.Language.allCases, id: \.self) { language in
                selectionButton(for: language, isSelected: language == viewModel.language) {
                    viewModel.language = language
                    Task { await viewModel.fetchRepositories() }
                }
            }
        } label: {
            Label(Constants.languageTitle, systemImage: Constants.languageImageName)
        }
    }
    
    private func selectionButton<T: SelectableOption>(for option: T, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                Text(option.rawValue.capitalized)
                Spacer()
                if isSelected {
                    Image(systemName: Constants.checkmarkImageName)
                }
            }
        }
    }

    private var loadingOverlay: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(1.5)
            }
        }
    }
}

// MARK: - SelectableOption

protocol SelectableOption {
    var rawValue: String { get }
}

extension RepositoryViewModel.Filter: SelectableOption {}
extension RepositoryViewModel.Language: SelectableOption {}
