//
//  GithubUITestsLaunchTests.swift
//  GithubUITests
//
//  Created by Mihail Salari on 12/2/23.
//

import XCTest

final class GithubUITestsLaunchTests: XCTestCase {
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-UITests"]
        app.launch()
        print(app.debugDescription)
    }
    
    func testAppNavigationFlow() throws {
        captureScreen(name: "Welcome Screen")
    
        try testTapOnLogo()
        try testTapOnOpenAppButton()

        captureScreen(name: "Repositories Screen")

        try testTapOnFirstCell()
    }
    
    private func testTapOnLogo() throws {
        sleep(3)
        let logo = app.images[AccessibilityIdentifier.welcomeScreenLogo.name]
        XCTAssertTrue(logo.waitForExistence(timeout: 5), "Logo image does not exist.")
        logo.tap()
    }
    
    
    private func testTapOnOpenAppButton() throws {
        sleep(3)
        let goToButton = app.buttons[AccessibilityIdentifier.welcomeScreenGoToButton.name]
        XCTAssertTrue(goToButton.waitForExistence(timeout: 5))
        goToButton.tap()
    }
    
    private func testTapOnFirstCell() throws {
        sleep(3)
        let repositoriesTableView = app.collectionViews[AccessibilityIdentifier.repositoriesTableView.name]
        XCTAssertTrue(repositoriesTableView.waitForExistence(timeout: 20), "Repositories table view didn't appear in time.")

        let firstCell = repositoriesTableView.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.waitForExistence(timeout: 20), "First row in repositories table does not exist")
        
        if firstCell.waitForExistence(timeout: 5) {
            firstCell.tap()

            captureScreen(name: "Repository Details")
            sleep(2)
            
            let closeButton = app.buttons[AccessibilityIdentifier.closeButton.name]
            closeButton.tap()

            captureScreen(name: "Repositories Screen After Detail")
        } else {
            XCTFail("First row in repositories table does not exist")
        }
    }

    private func captureScreen(name: String) {
        let screenshot = app.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
