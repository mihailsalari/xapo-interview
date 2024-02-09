//
//  StatsView.swift
//  Github
//
//  Created by Mihail Salari on 12/2/23.
//

import SwiftUI

struct StatsView: View {
    private struct Constants {
        static let spacing: CGFloat = 6
        static let languageIconSize: CGFloat = 16
        static let detailFontSize: CGFloat = 13
    }
    
    let imageName: String
    let count: Int
    
    var body: some View {
        HStack(spacing: Constants.spacing) {
            Image(imageName)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.secondary)
                .frame(width: Constants.languageIconSize, height: Constants.languageIconSize)
            
            Text("\(count)")
                .foregroundColor(.secondary)
                .font(.system(size: Constants.detailFontSize))
        }
    }
}
