//
//  ProfileImageView.swift
//  Github
//
//  Created by Mihail Salari on 12/2/23.
//

import Foundation
import SwiftUI

struct ProfileImageView: View {
    private struct Constants {
        static let imageSize: CGFloat = 48
    }
    
    @ObservedObject var viewModel: RepositoryViewModel
    let urlString: String
    
    var body: some View {
        Image(uiImage: viewModel.image(for: urlString))
            .resizable()
            .clipShape(Circle())
            .frame(width: Constants.imageSize, height: Constants.imageSize)
            .scaledToFit()
    }
}
