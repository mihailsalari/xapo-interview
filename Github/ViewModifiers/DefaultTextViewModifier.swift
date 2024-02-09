//
//  DefaultTextViewModifier.swift
//  Github
//
//  Created by Mihail Salari on 12/2/23.
//

import SwiftUI

struct DefaultTextViewModifier: ViewModifier {
    let fontSize: CGFloat
    let fontWeight: Font.Weight

    func body(content: Content) -> some View {
        content
            .foregroundColor(Color(.white))
            .multilineTextAlignment(.center)
            .font(.system(size: fontSize, weight: fontWeight))
            .padding(.horizontal, 20)
    }
}

extension View {
    func withDefaultTextViewModifier() -> some View {
        modifier(DefaultTextViewModifier(fontSize: 15, fontWeight: .regular))
    }
}
