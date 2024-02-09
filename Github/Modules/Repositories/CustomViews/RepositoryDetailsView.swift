//
//  RepositoryDetailsView.swift
//  Github
//
//  Created by Mihail Salari on 12/2/23.
//

import SwiftUI
import SwiftNetwork

struct RepositoryDetailsView: View {
    private struct Constants {
        static let spacing: CGFloat = 8
    }
    
    let repository: Repository
    
    var body: some View {
        VStack(alignment: .leading, spacing: Constants.spacing) {
            Text(repository.fullName)
                .font(.headline)
                .lineLimit(2)
            
            Text(repository.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(4)
            
            Divider().background(Color.accentColor)
        }
        .padding(.horizontal)
    }
}
