//
//  GithubAppUITests.swift
//  GithubUITests
//
//  Created by Mihail Salari on 12/2/23.
//

import XCTest

final class AppFlowSnapshotTests: XCTestCase {
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-UITests"]
        app.launch()
    }
    
    func testLaunchScreenAppearance() throws {
        let launchScreenScreenshot = app.screenshot()
        let launchScreenAttachment = XCTAttachment(screenshot: launchScreenScreenshot)
        launchScreenAttachment.name = "Launch Screen"
        launchScreenAttachment.lifetime = .keepAlways
        add(launchScreenAttachment)
        
        let proceedToWelcomeScreenElement = app.buttons[AccessibilityIdentifier.welcomeScreenGoToButton.name]
        if proceedToWelcomeScreenElement.waitForExistence(timeout: 10) {
            proceedToWelcomeScreenElement.tap()

            let welcomeScreenScreenshot = app.screenshot()
            let welcomeScreenAttachment = XCTAttachment(screenshot: welcomeScreenScreenshot)
            welcomeScreenAttachment.name = "Welcome Screen"
            welcomeScreenAttachment.lifetime = .keepAlways
            add(welcomeScreenAttachment)
            
        } else {
            XCTFail("Welcome screen button does not exist")
        }
    }
}
