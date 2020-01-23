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

    override func tearDown() {
    }

    func testRandomWordGetting() {
        XCTAssert(sut.buttons["PLAY"].exists)
        
    }

    func testCustomWordGetting() {

        let app = XCUIApplication()
        app.textFields["WORD TO GUESS"].tap()

        let aKey = app/*@START_MENU_TOKEN@*/.keys["A"]/*[[".keyboards.keys[\"A\"]",".keys[\"A\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        aKey.tap()
        aKey.tap()
        aKey.tap()
        aKey.tap()
        aKey.tap()
        aKey.tap()
        aKey.tap()
        aKey.tap()
        aKey.tap()
        aKey.tap()
        aKey.tap()
        app.buttons["PLAY"].tap()
        app.buttons["A"].tap()
        app.staticTexts["YOU WON"].tap()
        app.staticTexts["IT TOOK YOU 43.672093011319554 SECONDS"].tap()
        app.buttons["TRY ONCE AGAIN"].tap()

    }

    func testInitialWordHiding() {

    }

    func testLetterDoubleClickNotPossible() {

    }

    func testIfGameEnds() {

    }

}
