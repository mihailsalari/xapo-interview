//
//  ColorExtensionTests.swift
//  GithubTests
//
//  Created by Mihail Salari on 12/2/23.
//

import Foundation
import XCTest
import SwiftUI

@testable import Github
final class ColorExtensionTests: XCTestCase {

    func testColorFromHex3Digits() {
        // Given
        let hexString = "#1A2"

        // When
        let color = Color(hex: hexString)

        // Then
        XCTAssertEqual(color, Color(red: 0x11 / 255, green: 0xAA / 255, blue: 0x22 / 255))
    }

    func testColorFromHex6Digits() {
        let hexString = "#1A2B3C"
        let color = Color(hex: hexString)
        XCTAssertEqual(color, Color(red: 0x1A / 255, green: 0x2B / 255, blue: 0x3C / 255))
    }

    func testColorFromHex8Digits() {
        let hexString = "#FF1A2B3C"
        let color = Color(hex: hexString)
        XCTAssertEqual(color, Color(red: 0x1A / 255, green: 0x2B / 255, blue: 0x3C / 255, opacity: 1.0))
    }

    func testColorFromInvalidHex() {
        let hexString = "#XYZ"
        let color = Color(hex: hexString)
        XCTAssertEqual(color, Color(red: 0, green: 0, blue: 0))
    }
}
