//
//  DefaultPrivacyTextViewModifier.swift
//  Github
//
//  Created by Mihail Salari on 12/2/23.
//

import SwiftUI

struct DefaultPrivacyTextViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .underline()
                .foregroundColor(Color(.splashText))
        } else {
            // TODO: - Fix the underline
            content
            .foregroundColor(Color(.splashText))
        }
    }
}
