//
//  RepositoryDetailView.swift
//  Github
//
//  Created by Mihail Salari on 12/2/23.
//

import SwiftUI
import SwiftNetwork

struct RepositoryDetailView: View {
    @State private var isShareSheetPresented = false
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: RepositoryViewModel
    let repository: Repository
    var coordinator: any AppCoordinatorProtocol
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        RepositoryRow(viewModel: viewModel, repository: repository)
                            .padding(.leading)
                        
                        if let url = URL(string: repository.url) {
                            visitOnGithub(url)
                        }
                        
                        if let markdownContent = viewModel.markdownContent {
                            Text(markdownContent)
                                .padding(12)
                        } else if viewModel.isLoading && viewModel.toast == nil {
                            ProgressView()
                                .padding()
                        }
                        
                        Spacer()
                    }
                }
            }
            .navigationTitle(repository.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    closeButton
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    shareButton
                }
            }
            .sheet(isPresented: $isShareSheetPresented) {
                coordinator.showShareScreen(with: repository.url)
            }
            .toast(toast: $viewModel.toast)
            .onAppear {
                Task {
                    await viewModel.fetchDescription(from: repository)
                }
            }
            .onDisappear {
                viewModel.toast = nil
            }
        }
        .accessibility(identifier: .repositoryDetailView)
    }
    
    private var closeButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "xmark.circle.fill")
                .foregroundColor(.gray)
        }
        .accessibility(identifier: .closeButton)
    }
    
    private var shareButton: some View {
        Button(action: {
            isShareSheetPresented = true
        }) {
            Image(systemName: "square.and.arrow.up")
        }
    }
    
    private func visitOnGithub(_ url: URL) -> some View {
        Link(destination: url) {
            Text("Visit on GitHub".localized)
                .font(.headline)
                .foregroundColor(.blue)
                .padding(.horizontal)
                .padding(.top, 4)
        }
    }
}
