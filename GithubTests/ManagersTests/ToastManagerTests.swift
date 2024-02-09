//
//  ToastManagerTests.swift
//  GithubTests
//
//  Created by Mihail Salari on 12/2/23.
//

import Foundation
import XCTest
import SwiftUI

@testable import Github
final class ToastManagerTests: XCTestCase {
    private var toastManager: ToastManager!

    override func setUp() {
        super.setUp()
        toastManager = ToastManager()
    }

    override func tearDown() {
        toastManager = nil
        super.tearDown()
    }

    func testShowToast_WhenCalledWithErrorMessage_ShouldUpdateCurrentToastWithErrorType() {
        // Given
        let errorMessage = "Error occurred"

        // When
        toastManager.show(message: errorMessage, type: .error)

        // Then
        XCTAssertNotNil(toastManager.currentToast)
        XCTAssertEqual(toastManager.currentToast?.message, errorMessage)
        XCTAssertEqual(toastManager.currentToast?.type, .error)
    }

    func testShowToast_WhenCalledWithSuccessMessage_ShouldUpdateCurrentToastWithSuccessType() {
        // Given
        let successMessage = "Operation successful"

        // When
        toastManager.show(message: successMessage, type: .success)

        // Then
        XCTAssertNotNil(toastManager.currentToast)
        XCTAssertEqual(toastManager.currentToast?.message, successMessage)
        XCTAssertEqual(toastManager.currentToast?.type, .success)
    }

    func testShowToast_WhenCalledWithWarningMessage_ShouldUpdateCurrentToastWithWarningType() {
        // Given
        let warningMessage = "Warning issued"

        // When
        toastManager.show(message: warningMessage, type: .warning)

        // Then
        XCTAssertNotNil(toastManager.currentToast)
        XCTAssertEqual(toastManager.currentToast?.message, warningMessage)
        XCTAssertEqual(toastManager.currentToast?.type, .warning)
    }
}
