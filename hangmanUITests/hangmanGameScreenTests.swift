//
//  hangmanGameScreenTests.swift
//  hangmanUITests
//
//  Created by Jakub Towarek on 11/09/2019.
//  Copyright © 2019 Jakub Towarek. All rights reserved.
//

import XCTest



class hangmanGameScreenTests: XCTestCase {

    let sut = XCUIApplication()
    let mockedCustomWord = "TOWAREK"
    let unbeatableCustomWord = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1"

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        sut.launchArguments += ["UI-TESTING"]
        let url = #"http://puzzle.mead.io/puzzle?wordCount=1"#
        let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.environmentalVariableNameAllowed)!
        let mockedResponse = #"{"puzzle":"\#(mockedCustomWord)"}"#
        sut.launchEnvironment[encodedUrl] = mockedResponse
        sut.launch()
    }

    func testRandomWordGetting() {
        XCTAssert(sut.buttons[AccessibilityIdentifiers.startScreenStartButton].exists)
        sut.buttons[AccessibilityIdentifiers.startScreenStartButton].tap()
        let hiddenWordLabel: XCUIElement = sut.staticTexts[AccessibilityIdentifiers.gameScreenHiddenWordLabel]
        XCTAssertEqual(hiddenWordLabel.label.filter({ $0 == "_" }).count, mockedCustomWord.count)
    }

    func testCustomWordGetting() {
        sut.switches[AccessibilityIdentifiers.startScreenRandomWordSwitch].tap()
        sut.textFields[AccessibilityIdentifiers.startScreenCustomWordTextField].tap()
        sut.textFields[AccessibilityIdentifiers.startScreenCustomWordTextField].typeText(mockedCustomWord)
        sleep(1)
        sut.buttons[AccessibilityIdentifiers.startScreenStartButton].tap()
        let hiddenWordLabel = sut.staticTexts[AccessibilityIdentifiers.gameScreenHiddenWordLabel]
        XCTAssert(hiddenWordLabel.exists)
        mockedCustomWord.forEach({ letter in
            sut.buttons[String(letter)].tap()
        })
        XCTAssertFalse(hiddenWordLabel.exists)
    }

    func testInitialWordHiding() {
        sut.buttons[AccessibilityIdentifiers.startScreenStartButton].tap()
        let hiddenWordLabel: XCUIElement = sut.staticTexts[AccessibilityIdentifiers.gameScreenHiddenWordLabel]
        sleep(1)
        XCTAssert(hiddenWordLabel.label.allSatisfy({$0 == "_"}))
    }

    func testLetterDoubleClickNotPossible() {
        sut.terminate()
        let url = #"http://puzzle.mead.io/puzzle?wordCount=1"#
        let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.environmentalVariableNameAllowed)!
        let mockedResponse = #"{"puzzle":"\#(unbeatableCustomWord)"}"#
        sut.launchEnvironment[encodedUrl] = mockedResponse
        sut.launch()

        XCTAssert(sut.buttons[AccessibilityIdentifiers.startScreenStartButton].waitForExistence(timeout: 5.0))
        sut.buttons[AccessibilityIdentifiers.startScreenStartButton].tap()
        sleep(2)

        for letter in "ABCDEFGHIJKLMNOPQRSTUVWXYZ" {
            XCTAssertTrue(sut.buttons[String(letter)].isEnabled)
            sut.buttons[String(letter)].tap()
            XCTAssertFalse(sut.buttons[String(letter)].isEnabled)
        }
    }

    func testIfGameEnds() {
        sut.switches[AccessibilityIdentifiers.startScreenRandomWordSwitch].tap()
        sut.textFields[AccessibilityIdentifiers.startScreenCustomWordTextField].tap()
        sut.textFields[AccessibilityIdentifiers.startScreenCustomWordTextField].typeText(mockedCustomWord)
        sleep(1)
        sut.buttons[AccessibilityIdentifiers.startScreenStartButton].tap()
        let hiddenWordLabel = sut.staticTexts[AccessibilityIdentifiers.gameScreenHiddenWordLabel]
        XCTAssert(hiddenWordLabel.exists)
        mockedCustomWord.forEach({ letter in
            sut.buttons[String(letter)].tap()
        })
        XCTAssertFalse(hiddenWordLabel.exists)
    }
}
