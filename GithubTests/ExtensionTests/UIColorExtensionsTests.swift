//
//  ToastManagerTests.swift
//  GithubTests
//
//  Created by Mihail Salari on 12/2/23.
//

import UIKit
import XCTest
import SwiftUI

@testable import Github
final class UIColorExtensionsTests: XCTestCase {
    func testColorExists() {
        // Given
        let colorName = AppColorType.AccentColor.rawValue

        // When
        let color = UIColor(named: colorName)

        // Then
        XCTAssertNotNil(color)
    }

    func testColorNotExists() {
        // Given
        let colorName = AppColorType.none
        
        // When
        do {
            let color: UIColor? = try UIColor.color(named: colorName)
            XCTAssertNil(color)
        } catch {
            // Then
            XCTAssertNotNil(error)
        }
    }
}
