//
//  StringExtensionsTests.swift
//  GithubTests
//
//  Created by Mihail Salari on 12/2/23.
//

import Foundation
import XCTest
import SwiftUI

@testable import Github
final class StringExtensionsTests: XCTestCase {
    func testLocalizationExists() {
        // Given
        let key = "KnownLocalizationKey"

        // When
        let localizedString = key.localized

        // Then
        let expectedLocalizedString = NSLocalizedString(key, comment: "")
        XCTAssertEqual(localizedString, expectedLocalizedString)
    }

    func testLocalizationNotExists() {
        // Given
        let key = "UnknownKey"

        // When
        let localizedString = key.localized

        // Then
        XCTAssertEqual(localizedString, key)
    }

    // Testing HTML Tag Removal Extension

    func testRemoveHTMLTags() {
        // Given
        let stringWithHTML = "<p>Hello, <b>World!</b></p>"

        // When
        let stringWithoutHTML = stringWithHTML.deleteHTMLTags

        // Then
        XCTAssertEqual(stringWithoutHTML, "Hello, World!")
    }

    func testStringWithoutHTMLTags() {
        // Given
        let plainString = "Hello, World!"

        // When
        let resultString = plainString.deleteHTMLTags

        // Then
        XCTAssertEqual(resultString, plainString)
    }
}
