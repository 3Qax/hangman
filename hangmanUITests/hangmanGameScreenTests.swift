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

    override func setUp() {
        super.setUp()
        continueAfterFailure = false

        sut.launchArguments += ["UI-TESTING"]
//        sut.launchEnvironment["http://puzzle.mead.io/puzzle?wordCount=1"] = #"{"puzzle":"TOWAREK"}"#
        sut.launchEnvironment["AAA"] = #"{"puzzle":"TOWAREK"}"#
        sut.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRandomWordGetting() {
        
        sut.buttons["PLAY"].tap()
        sut.buttons["T"].tap()
        sut.buttons["O"].tap()
        sut.buttons["W"].tap()
        sut.buttons["A"].tap()
        sut.buttons["R"].tap()
        sut.buttons["E"].tap()
        sut.buttons["K"].tap()
    }

}
