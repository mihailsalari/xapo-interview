//
//  LanguageView.swift
//  Github
//
//  Created by Mihail Salari on 12/2/23.
//

import SwiftUI

struct LanguageView: View {
    private struct Constants {
        static let languageIconSize: CGFloat = 16
        static let detailFontSize: CGFloat = 13
        static let spacing: CGFloat = 6
    }
    
    let language: String
    let colorHex: String
    
    var body: some View {
        HStack(spacing:  Constants.spacing) {
            Circle()
                .foregroundColor(Color(hex: colorHex))
                .frame(width: Constants.languageIconSize)
            
            Text(language)
                .foregroundColor(.secondary)
                .font(.system(size: Constants.detailFontSize))
        }
    }
}
