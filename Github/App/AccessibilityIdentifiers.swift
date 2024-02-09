//
//  AccessibilityIdentifiers.swift
//  Github
//
//  Created by Mihail Salari on 12/2/23.
//

import Foundation
import SwiftUI

enum AccessibilityIdentifier: String {
    case splashScreenImage
    case splashScreenGradient
    
    case welcomeScreenTitle
    case welcomeScreenLogo
    case welcomeScreenGoToButton

    case repositoriesTableView

    case repositoryDetailView
    case closeButton
    
    var name: String {
        return rawValue.capitalized + "Identifier"
    }
}

struct AccessibilityModifier: ViewModifier {
    let identifier: AccessibilityIdentifier
    
    func body(content: Content) -> some View {
        content.accessibilityIdentifier(identifier.name)
    }
}

extension View {
    func accessibility(identifier: AccessibilityIdentifier) -> some View {
        self.modifier(AccessibilityModifier(identifier: identifier))
    }
}
