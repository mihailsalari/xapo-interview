//
//  ShareSheetTests.swift
//  GithubTests
//
//  Created by Mihail Salari on 12/2/23.
//

import Foundation
import XCTest
import SwiftUI

@testable import Github
final class ShareSheetTests: XCTestCase {

    func testShareSheet_WhenInitializedWithActivityItems_ShouldContainThoseItems() {
        // Given
        let testItems = ["Test String", URL(string: "https://example.com")!] as [Any]

        // When
        let shareSheet = ShareSheet(activityItems: testItems)

        // Then
        XCTAssertEqual(shareSheet.activityItems.count, testItems.count)
        XCTAssertTrue(shareSheet.activityItems.contains(where: { $0 as? String == "Test String" }))
        XCTAssertTrue(shareSheet.activityItems.contains(where: { $0 as? URL == URL(string: "https://example.com")! }))
    }
}
