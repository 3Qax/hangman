//
//  hangmanStartScreenTests.swift
//  hangmanUITests
//
//  Created by Jakub Towarek on 19/01/2020.
//  Copyright © 2020 Jakub Towarek. All rights reserved.
//

import XCTest

class hangmanStartScreenTests: XCTestCase {

    let sut = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        sut.launch()
    }

    func testStartValues() {
        let randomWordSwitch: XCUIElement = sut.switches[AccessibilityIdentifiers.startScreenRandomWordSwitch]
        XCTAssertEqual(randomWordSwitch.value as? String, "1")
        XCTAssertTrue(sut.buttons[AccessibilityIdentifiers.startScreenStartButton].isEnabled)
    }


    func testCustomWordAppears() {
        sut.switches[AccessibilityIdentifiers.startScreenRandomWordSwitch].tap()
        XCTAssertTrue(sut.textFields[AccessibilityIdentifiers.startScreenCustomWordTextField].exists)
        XCTAssertFalse(sut.buttons[AccessibilityIdentifiers.startScreenStartButton].isEnabled)
    }

    func testIfErrorMessageAppears() {
        sut.switches[AccessibilityIdentifiers.startScreenRandomWordSwitch].tap()
        let errorCount = sut.otherElements[AccessibilityIdentifiers.startScreenAdditionalContentStackView]
            .descendants(matching: .other)
            .matching(identifier: AccessibilityIdentifiers.messageBoxError)
            .count

        XCTAssertEqual(errorCount, 1)
    }

    func testIfErrorMessageDisappears() {
        sut.switches[AccessibilityIdentifiers.startScreenRandomWordSwitch].tap()
        let errorMessages = sut.otherElements[AccessibilityIdentifiers.startScreenAdditionalContentStackView]
            .descendants(matching: .other)
            .matching(identifier: AccessibilityIdentifiers.messageBoxError)

        XCTAssertEqual(errorMessages.count, 1)
        sut.textFields[AccessibilityIdentifiers.startScreenCustomWordTextField].typeText("TOWAREK")
        sleep(1)
        XCTAssertEqual(errorMessages.count, 0)
    }

}
