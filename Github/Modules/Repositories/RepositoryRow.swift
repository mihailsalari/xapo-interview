//
//  RepositoryRow.swift
//  Github
//
//  Created by Mihail Salari on 12/2/23.
//

import Foundation
import SwiftUI
import SwiftNetwork

struct RepositoryRow: View {
    private struct Constants {
        static let spacing: CGFloat = 12
    }
    
    @ObservedObject var viewModel: RepositoryViewModel
    let repository: Repository
    
    var body: some View {
        VStack(alignment: .trailing, spacing: Constants.spacing) {
            
            HStack(spacing: Constants.spacing) {
                ProfileImageView(viewModel: viewModel, urlString: repository.avatar)
                
                RepositoryDetailsView(repository: repository)
            }
            
            RepositoryStatsView(repository: repository)
        }
    }
}
