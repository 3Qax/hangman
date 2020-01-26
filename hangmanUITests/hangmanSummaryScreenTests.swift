//
//  hangmanSummaryScreenTests.swift
//  hangmanUITests
//
//  Created by Jakub Towarek on 19/01/2020.
//  Copyright © 2020 Jakub Towarek. All rights reserved.
//

import XCTest

class hangmanSummaryScreenTests: XCTestCase {

    let sut = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        sut.launch()
        sut.switches[AccessibilityIdentifiers.startScreenRandomWordSwitch].tap()
        sut.textFields[AccessibilityIdentifiers.startScreenCustomWordTextField].tap()
        sut.textFields[AccessibilityIdentifiers.startScreenCustomWordTextField].typeText("AAAAAAA")
        sleep(1)
        sut.buttons[AccessibilityIdentifiers.startScreenStartButton].tap()
    }

    func testIfShowsConfettiOnWin() {
        sut.buttons["A"].tap()
        XCTAssertTrue(sut.otherElements[AccessibilityIdentifiers.summaryScreenConfettiView].exists)
    }

    func testIfHidesConfettiOnLose() {
        "BCDEFGHIJKL".forEach { sut.buttons[String($0)].tap() }
        XCTAssertFalse(sut.otherElements[AccessibilityIdentifiers.summaryScreenConfettiView].exists)
    }

    func testIfDescriptionIsClipped() {
        // TODO: get a reference to description label as UILabel object, so that ⬇️ method could be called
    }

    func testCanStartNewGame() {
        sut.buttons["A"].tap()
        let button = sut.buttons[AccessibilityIdentifiers.summaryScreenPlayAgainButton]
        XCTAssertTrue(button.exists)
        button.tap()
        XCTAssertFalse(button.exists)
    }

}

private extension UILabel {

    var isTruncated: Bool {
        guard let labelText = text else { return false }
        let labelTextSize = (labelText as NSString).boundingRect(
            with: CGSize(width: frame.size.width, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: font as Any],
            context: nil).size
        return labelTextSize.height > bounds.size.height
    }
}
